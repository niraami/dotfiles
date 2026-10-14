#!/usr/bin/env python3
"""Capture screenshots and screen recordings under Hyprland.

hyprshot takes still images and wf-recorder records video. Options missing
from the command line are prompted for with fuzzel; regions, windows and
outputs are picked interactively with slurp and saved files are announced
through dunst notifications. While a recording runs, a tray icon offers to
stop it.

Re-running with `--action video` while a recording is in progress stops it.

Depends on: hyprctl, hyprshot, wf-recorder, slurp, fuzzel, dunstify,
swappy and xdg-open. The tray icon additionally needs PyGObject with
AyatanaAppIndicator3 or AppIndicator3.
"""

import argparse
import json
import math
import os
import re
import signal
import subprocess
import sys
import time

from datetime import datetime
from pathlib import Path

TIME_FORMAT = "%Y-%m-%d_%H-%M-%S"

IMAGE_NAME_POSTFIX = ""
VIDEO_NAME_POSTFIX = ""

IMAGE_MODES = [
  ("Capture region", "region"),
  ("Capture screen", "output"),
  ("Capture window", "window"),
]
VIDEO_MODES = [
  ("Record region", "region"),
  ("Record screen", "output"),
  ("Record window", "window"),
]
VIDEO_FORMATS = [
  ("MP4 (H.264)", "h264"),
  ("MP4 (H.265)", "h265"),
  ("MP4 (AV1)", "av1"),
  ("GIF", "gif"),
]
VIDEO_FPS = [("24 fps", 24), ("30 fps", 30), ("60 fps", 60)]
GIF_FPS = [("15 fps", 15), ("24 fps", 24), ("30 fps", 30)]

_GEOMETRY = re.compile(r"(?P<x>-?\d+),(?P<y>-?\d+) (?P<w>\d+)x(?P<h>\d+)")


def timestamp() -> str:
  return datetime.now().strftime(TIME_FORMAT)


def xdg_dir(name: str, default: str) -> Path:
  """Resolve an XDG user dir ('PICTURES', 'VIDEOS', ...) like xdg-user-dir."""
  value = os.environ.get(f"XDG_{name}_DIR")
  if value:
    return Path(value)

  config_home = Path(os.environ.get("XDG_CONFIG_HOME") or Path.home() / ".config")
  try:
    lines = (config_home / "user-dirs.dirs").read_text().splitlines()
  except OSError:
    lines = []
  for line in lines:
    match = re.fullmatch(rf'XDG_{name}_DIR="(.+)"', line.strip())
    if match:
      path = Path(match.group(1).replace("$HOME", str(Path.home())))
      return path if path.is_absolute() else Path.home() / path

  return Path.home() / default


def fuzzel_prompt(options):
  """Offer option labels in a fuzzel menu and return the chosen value; None
  when the menu is dismissed or unmatched text is entered."""
  proc = subprocess.run(
    ["fuzzel", "--dmenu", "--prompt", "󰄀 ", "--width", "25",
     "--lines", "6", "--log-level=none"],
    input="\n".join(label for label, _ in options),
    capture_output=True, text=True)
  if proc.returncode != 0:
    return None
  choice = proc.stdout.rstrip("\n")
  return next((value for label, value in options if label == choice), None)


def slurp(*args: str, stdin: str = "") -> str | None:
  """Interactive slurp selection; None when cancelled."""
  proc = subprocess.run(["slurp", *args], input=stdin,
                        capture_output=True, text=True)
  if proc.returncode != 0:
    return None
  return proc.stdout.strip() or None


def hyprctl(*args: str):
  """Parsed JSON output of `hyprctl -j ...`."""
  proc = subprocess.run(["hyprctl", "-j", *args],
                        capture_output=True, text=True, check=True)
  return json.loads(proc.stdout)


def window_geometries() -> list[str]:
  """'x,y WxH' boxes of the windows on currently visible workspaces."""
  workspaces = {mon["activeWorkspace"]["id"] for mon in hyprctl("monitors")}
  return [
    f"{c['at'][0]},{c['at'][1]} {c['size'][0]}x{c['size'][1]}"
    for c in hyprctl("clients")
    if c.get("workspace", {}).get("id") in workspaces
  ]


def trim_geometry(geometry: str) -> str | None:
  """Clip an 'x,y WxH' box to the output it overlaps the most; wf-recorder
  only accepts geometry fully inside a single output."""
  match = _GEOMETRY.search(geometry)
  if match is None:
    return None
  x, y, w, h = (int(match.group(k)) for k in "xywh")

  best = None
  for mon in hyprctl("monitors"):
    mw = math.floor(mon["width"] / mon["scale"] + 0.5)
    mh = math.floor(mon["height"] / mon["scale"] + 0.5)
    ix, iy = max(x, mon["x"]), max(y, mon["y"])
    iw = min(x + w, mon["x"] + mw) - ix
    ih = min(y + h, mon["y"] + mh) - iy
    if best is None or iw * ih > best[2] * best[3]:
      best = ix, iy, iw, ih

  if best is None or best[2] <= 0 or best[3] <= 0:
    return None
  return f"{best[0]},{best[1]} {best[2]}x{best[3]}"


def wf_recorder_pids() -> list[int]:
  pids = []
  for entry in Path("/proc").iterdir():
    if entry.name.isdigit():
      try:
        if (entry / "comm").read_text().strip() == "wf-recorder":
          pids.append(int(entry.name))
      except OSError:
        continue
  return pids


def notify(summary: str, body: str, urgency: str = "low"):
  """Fire-and-forget notification; dunstify blocks until the notification
  closes, so it runs as a detached process."""
  subprocess.Popen(
    ["dunstify", "--appname=Screen Capture", f"--urgency={urgency}",
     summary, body],
    stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL, start_new_session=True)


def notify_dialog(summary: str, body: str, icon: str, file_path: Path,
                  edit: bool = False):
  """Detached notification offering to open the file location, optionally
  also to edit the file with swappy."""
  actions = [["open", "Open file location"]]
  if edit:
    actions.append(["edit", "Edit with swappy"])
  payload = {"summary": summary, "body": body, "icon": icon,
             "file": str(file_path), "actions": actions}
  subprocess.Popen(
    [sys.executable, str(Path(__file__).resolve()),
     "--notify-handler", json.dumps(payload)],
    stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL, start_new_session=True)


def handle_notification(payload: dict):
  """Blocking part of notify_dialog(), run in the detached child: show the
  notification and dispatch the selected action."""
  command = ["dunstify", "--appname=Screen Capture", "--urgency=low"]
  if payload.get("icon"):
    command.append(f"--icon={payload['icon']}")
  for name, label in payload["actions"]:
    command.append(f"--action={name},{label}")
  proc = subprocess.run([*command, payload["summary"], payload["body"]],
                        capture_output=True, text=True)

  file_path = Path(payload["file"])
  targets = {
    "open": ["xdg-open", str(file_path.parent)],
    "edit": ["swappy", "--file", str(file_path)],
  }
  if proc.stdout.strip() in targets:
    subprocess.Popen(targets[proc.stdout.strip()])


def stop_recorders():
  for pid in wf_recorder_pids():
    try:
      os.kill(pid, signal.SIGINT)
    except OSError:
      pass


def tray_icon_supported() -> bool:
  try:
    import gi
    gi.require_version("Gtk", "3.0")
    try:
      gi.require_version("AyatanaAppIndicator3", "0.1")
    except ValueError:
      gi.require_version("AppIndicator3", "0.1")
    return True
  except (ImportError, ValueError):
    return False


def spawn_tray_icon(file_path: Path) -> subprocess.Popen:
  """Detached tray-icon process marking an ongoing recording."""
  return subprocess.Popen(
    [sys.executable, str(Path(__file__).resolve()),
     "--tray-icon", str(file_path)],
    stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL, start_new_session=True)


def run_tray_icon(file_path: str):
  """Blocking part of spawn_tray_icon(), run in the detached child: a tray
  icon with a 'Stop recording' menu entry, gone once the recording ends."""
  import gi
  gi.require_version("Gtk", "3.0")
  try:
    gi.require_version("AyatanaAppIndicator3", "0.1")
    from gi.repository import AyatanaAppIndicator3 as AppIndicator
  except ValueError:
    gi.require_version("AppIndicator3", "0.1")
    from gi.repository import AppIndicator3 as AppIndicator
  from gi.repository import Gtk, GLib

  indicator = AppIndicator.Indicator.new(
    "hypr-capture", "media-record",
    AppIndicator.IndicatorCategory.APPLICATION_STATUS)
  indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE)
  if hasattr(indicator, "set_title"):
    indicator.set_title(f"Recording to {file_path}")

  menu = Gtk.Menu()
  item = Gtk.MenuItem(label="Stop recording")
  item.connect("activate", lambda *_: stop_recorders())
  menu.append(item)
  menu.show_all()
  indicator.set_menu(menu)
  # Middle-click activates the item directly where the host supports it
  if hasattr(indicator, "set_secondary_activate_target"):
    indicator.set_secondary_activate_target(item)

  # Leave once no recorder is left (keybind stop, dead parent)
  def check_recorders():
    if not wf_recorder_pids():
      Gtk.main_quit()
    return True

  GLib.timeout_add_seconds(1, check_recorders)
  Gtk.main()


def encoder_args(fmt: str, fps: int) -> tuple[str, list[str]]:
  """File extension and extra wf-recorder arguments for a video format."""
  try:
    return {
      "h264": ("mp4", ["-c", "libx264", "-x", "yuv420p", "-r", str(fps)]),
      "h265": ("mp4", ["-c", "libx265", "-x", "yuv420p", "-r", str(fps)]),
      # libsvtav1 and librav1e both fail under wf-recorder 0.6.0 (bad
      # parameter / panic); libaom's software encoder is the reliable AV1
      # option for now
      "av1": ("mp4", ["-c", "libaom-av1", "-x", "yuv420p",
                      "-p", "usage=realtime", "-p", "cpu-used=8",
                      "-r", str(fps)]),
      "gif": ("gif", ["-c", "gif", "-F",
                      f"fps={fps},split[s0][s1];"
                      "[s0]palettegen=stats_mode=single[p];"
                      "[s1][p]paletteuse=dither=bayer"]),
    }[fmt]
  except KeyError:
    raise ValueError(f"invalid format: {fmt}")


def capture_image(mode: str | None) -> int:
  if mode is None:
    mode = fuzzel_prompt(IMAGE_MODES)
    if mode is None:
      return 0
    time.sleep(0.9)  # let the fuzzel window close first

  name = timestamp() + (f"_{IMAGE_NAME_POSTFIX}" if IMAGE_NAME_POSTFIX else "")
  out_path = xdg_dir("PICTURES", "Pictures") / "Screenshots" / f"{name}.png"

  # hyprshot's exit status is unreliable; a cancelled selection simply never
  # writes a file
  subprocess.run(["hyprshot", "--silent", "--freeze", "--mode", mode,
                  "--filename", f"Screenshots/{name}.png"])

  # hyprshot may return before the file hits disk
  for _ in range(15):
    if out_path.is_file():
      break
    time.sleep(0.1)
  if not out_path.is_file():
    return 0

  notify_dialog("Screen capture", f"Capture saved to {out_path}",
                icon=str(out_path), file_path=out_path, edit=True)
  return 0


def capture_video(mode: str | None, fmt: str | None, fps: int | None) -> int:
  # Re-running while a recording is in progress stops it
  if wf_recorder_pids():
    stop_recorders()
    return 0

  prompted = False
  if mode is None:
    mode = fuzzel_prompt(VIDEO_MODES)
    if mode is None:
      return 0
    prompted = True
  if fmt is None:
    fmt = fuzzel_prompt(VIDEO_FORMATS)
    if fmt is None:
      return 0
    prompted = True
  if fps is None:
    fps = fuzzel_prompt(GIF_FPS if fmt == "gif" else VIDEO_FPS)
    if fps is None:
      return 0
    prompted = True
  if prompted:
    time.sleep(0.9)

  recorder_args = ["-y"]
  if mode == "region":
    selection = slurp("-d")
    if not selection:
      return 0
    geometry = trim_geometry(selection)
    if geometry is None:
      return 1
    recorder_args += ["-g", geometry]
  elif mode == "output":
    selection = slurp("-or", "-f", "%o")
    if not selection:
      return 0
    recorder_args += ["-o", selection]
  elif mode == "window":
    boxes = window_geometries()
    if not boxes:
      return 0
    selection = slurp("-r", stdin="\n".join(boxes) + "\n")
    if not selection:
      return 0
    geometry = trim_geometry(selection)
    if geometry is None:
      return 1
    recorder_args += ["-g", geometry]
  else:
    print(f"Invalid mode: {mode}", file=sys.stderr)
    return 1

  try:
    ext, encoder = encoder_args(fmt, fps)
  except ValueError:
    print(f"Invalid format: {fmt}", file=sys.stderr)
    return 1
  recorder_args += encoder

  name = timestamp() + (f"_{VIDEO_NAME_POSTFIX}" if VIDEO_NAME_POSTFIX else "")
  out_dir = xdg_dir("VIDEOS", "Videos") / "Recordings"
  out_dir.mkdir(parents=True, exist_ok=True)
  out_path = out_dir / f"{name}.{ext}"

  try:
    recorder = subprocess.Popen(
      ["wf-recorder", *recorder_args, "-f", str(out_path)])
  except OSError:
    notify("Screen recording", "Recording failed", urgency="critical")
    return 1

  # A tray icon marks the ongoing recording (click -> Stop recording);
  # without AppIndicator support fall back to a plain notification
  tray = None
  if tray_icon_supported():
    try:
      tray = spawn_tray_icon(out_path)
    except OSError:
      pass
  if tray is None:
    notify("Screen recording", f"Recording to {out_path}, re-run to stop")

  try:
    returncode = recorder.wait()
  except KeyboardInterrupt:
    returncode = 130
  if tray is not None:
    tray.terminate()

  if returncode == 0 and out_path.is_file():
    notify_dialog("Screen recording", f"Recording saved to {out_path}",
                  icon="video-x-generic", file_path=out_path)
  else:
    notify("Screen recording", "Recording failed", urgency="critical")
  return 0


def main() -> int:
  parser = argparse.ArgumentParser(
    prog=Path(__file__).name,
    description="Capture screenshots and screen recordings under Hyprland.")
  parser.add_argument("-a", "--action", choices=("image", "video"),
                      help="what to capture (required)")
  parser.add_argument("-m", "--mode",
                      choices=("region", "window", "output", "screen"),
                      help="what to select; 'screen' is an alias for 'output'")
  parser.add_argument("-f", "--format", dest="format",
                      choices=("h264", "h265", "av1", "gif"),
                      help="video format")
  parser.add_argument("-r", "--fps", type=int, help="video framerate")
  parser.add_argument("--notify-handler", metavar="JSON", help=argparse.SUPPRESS)
  parser.add_argument("--tray-icon", metavar="FILE", help=argparse.SUPPRESS)
  args = parser.parse_args()

  if args.notify_handler is not None:
    handle_notification(json.loads(args.notify_handler))
    return 0
  if args.tray_icon is not None:
    run_tray_icon(args.tray_icon)
    return 0
  if args.action is None:
    parser.error("the following arguments are required: -a/--action")

  mode = "output" if args.mode == "screen" else args.mode
  if args.action == "image":
    return capture_image(mode)
  return capture_video(mode, args.format, args.fps)


if __name__ == "__main__":
  try:
    sys.exit(main())
  except KeyboardInterrupt:
    sys.exit(130)
  except FileNotFoundError as error:
    print(f"error: command not found: {error.filename}", file=sys.stderr)
    sys.exit(1)
  except (OSError, subprocess.CalledProcessError, ValueError, KeyError) as error:
    print(f"error: {error}", file=sys.stderr)
    sys.exit(1)

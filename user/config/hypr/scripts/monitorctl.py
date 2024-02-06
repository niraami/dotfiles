#!/usr/bin/env python3

import sys
import json
import typing
import argparse
import subprocess
import tempfile

from enum import Enum
from pathlib import Path
from subprocess import CalledProcessError


class Command(Enum):
  ENABLE = 'enable'
  DISABLE = 'disable'

  # Source: https://stackoverflow.com/a/46385352
  def __str__(self):
    return self.name.lower()


def main(
    command: Command,
    monitor_name: typing.Optional[str] = None,
    *,
    force: bool = False,
    use_defaults: bool = False
):
  if not monitor_name:
    monitor_name = getFocusedMonitorName()

  fp = Path(tempfile.gettempdir()) / f'hyprland-{monitor_name}.state'

  if command == Command.ENABLE:
    enableMonitor(monitor_name, fp, force=force, use_defaults=use_defaults)
  elif command == Command.DISABLE:
    disableMonitor(monitor_name, fp)
  else:
    raise RuntimeError(f"Unhandled command ({command})")


def disableMonitor(monitor_name: str, config_file: Path):
  # Store monitor configuration into the tempfile
  with config_file.open('w') as fd:
    json.dump(getMonitorConfig(monitor_name), fd)

  try:
    subprocess.check_call(
      f'hyprctl keyword monitor {monitor_name},disable', shell=True)
  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")


def enableMonitor(
    monitor_name: str,
    config_file: Path,
    *,
    force: bool = False,
    use_defaults: bool = False
):
  # Check if the monitor is already enabled
  try:
    getMonitorConfig(monitor_name)

    if not force:
      printError("Monitor is already enabled. Use '-f' or '--force' "
                 "if you want to override the current configuration.")
      return
  except RuntimeError:
    pass

  try:
    if not config_file.exists():
      if not use_defaults:
        printError("Unable to find monitor state file. Use '--defaults' to "
                   "use preferred auto configuration instead.")
        return

      subprocess.check_call(
        f'hyprctl keyword monitor {monitor_name},preferred,auto,1', shell=True)
    else:
      with config_file.open('r') as fd:
        monitor = json.load(fd)

      monitor_cfg = '{name},{width}x{height}@{refresh_rate},{x}x{y},{scale}'\
          .format(
              name=monitor['name'],
              width=monitor['width'],
              height=monitor['height'],
              refresh_rate=monitor['refreshRate'],
              x=monitor['x'],
              y=monitor['y'],
              scale=monitor['scale']
          )

      subprocess.check_call(
        f'hyprctl keyword monitor {monitor_cfg}', shell=True)
  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")


def getFocusedMonitorName() -> str:
  try:
    monitor = next((m for m in getMonitors() if m['focused']), None)

    if not monitor:
      raise RuntimeError("No monitor is focused")
    else:
      return monitor['name']
  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")


def getMonitorConfig(name: typing.Optional[str] = None) -> typing.Any:
  try:
    monitor = next((m for m in getMonitors() if m.get('name') == name), None)

    if not monitor:
      printError(f'Invalid monitor name specified ({name})')
    return monitor

  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")


def getMonitors() -> typing.Any:
  return json.loads(subprocess.check_output('hyprctl monitors -j', shell=True))


def printError(*args, **kwargs):
  print(*args, file=sys.stderr, **kwargs)


if __name__ == '__main__':
  parser = argparse.ArgumentParser(
    description="Hyprland monitor configuration control utility.")

  parser.add_argument('command', choices=list(Command), type=Command,
                      help="Action to perform on the monitor")
  parser.add_argument('monitor', nargs='?',
                      help="The name of the monitor (ex.: DP-1 or HDMI-A-1), "
                      "currently focused monitor is used if not specified")
  parser.add_argument('--force', '-f', dest='force', action='store_true',
                      help="Force configuration reload if the monitor is "
                      "already enabled")
  parser.add_argument('--defaults', dest='defaults', action='store_true',
                      help="Use preferred monitor defaults if no state file is "
                      "found")

  args = parser.parse_args()

  # Call main function with parsed arguments
  main(args.command, args.monitor, force=args.force, use_defaults=args.defaults)

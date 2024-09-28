#!/usr/bin/env python3

import json
import typing
import argparse
import subprocess

from subprocess import CalledProcessError


def main(mode: str, wn: typing.Optional[int]):
  dispatcher = 'movetoworkspace' if mode == 'move' else 'workspace'
  monitor_id = get_focused_monitor_id()

  workspace_id = monitor_id * 10 + wn

  try:
    subprocess.check_call(
      f"hyprctl dispatch {dispatcher} {workspace_id}", shell=True)
  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")

def get_focused_monitor_id() -> int:
  try:
    monitors = json.loads(
        subprocess.check_output('hyprctl monitors -j', shell=True)
    )

    for monitor in monitors:
      if monitor['focused']:
        return monitor['id']
        
    raise RuntimeError("No monitor is focused")
  except CalledProcessError as e:
    raise RuntimeError(f"Error executing hyprctl command: {e}")

if __name__ == '__main__':
  parser = argparse.ArgumentParser(
    description="Expands your Hyprland workspace needs.")

  parser_mode = parser.add_subparsers(dest="mode", required=True)

  open_parser = parser_mode.add_parser("open", help="Open a workspace")
  open_parser.add_argument("wn", type=int, help="Local workspace number")

  move_parser = parser_mode.add_parser("move",
    help="Move active window to a workspace")
  move_parser.add_argument("wn", type=int, help="Local workspace number")

  args = parser.parse_args()

  # Call main function with parsed arguments
  main(args.mode, args.wn if hasattr(args, "wn") else None)

#!/usr/bin/env python3

import os
import sys
import time
import json
import socket
import random
import fnmatch
import typing
import argparse
import subprocess

from pathlib import Path

valid_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.tga']


def main(args):
  while True:
    # Refresh list of images on each cycle
    images: list[str] = get_images(args.dirs)
    if not images:
      sys.exit(f"No images found in: {', '.join(args.dirs)}")

    if (args.per_output):
      for output in get_outputs():
        image_path: str = random.choice(images)
        subprocess.run(['awww', 'img', '--outputs', output, image_path], check=True)
    else:
      image_path: str = random.choice(images)
      subprocess.run(['awww', 'img', image_path], check=True)

    if args.watch:
      watch_outputs(args.dirs)

    if not args.cycle:
      return

    time.sleep(args.cycle)

def watch_outputs(dirs: list[str]):
  # Give every monitor that gets connected/enabled later its own random image
  sock_path = Path(os.environ['XDG_RUNTIME_DIR'], 'hypr',
                   os.environ['HYPRLAND_INSTANCE_SIGNATURE'], '.socket2.sock')

  with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.connect(str(sock_path))

    for line in sock.makefile():
      # monitoraddedv2>>ID,NAME,DESCRIPTION
      event, _, data = line.partition('>>')
      if event != 'monitoraddedv2':
        continue

      output = data.split(',')[1]
      images = get_images(dirs)
      if not images:
        continue
      image_path = random.choice(images)

      # The event can arrive before awww-daemon knows about the output
      for _ in range(10):
        if subprocess.run(['awww', 'img', '--outputs', output, image_path]).returncode == 0:
          break
        time.sleep(0.5)

def get_outputs() -> list[str]:
  # Execute the "hyperctl monitors" command and capture its output
  output = subprocess.check_output(['hyprctl', 'monitors', '-j'])

  # Parse the output as a JSON array of monitor objects
  monitors = json.loads(output)

  # Extract the name of each monitor and store it in a list
  monitor_names = [monitor['name'] for monitor in monitors]

  return monitor_names

def get_images(dirs: list[str]) -> list[str]:
  image_files = set()

  for d in dirs:
    path = Path(d).resolve()
    all_files = [str(fn) for fn in path.rglob('*')]

    for ext in valid_extensions:
      matches = set(fnmatch.filter(all_files, '*' + ext))
      image_files |= matches
  
  return list(image_files)

if __name__ == '__main__':
  parser = argparse.ArgumentParser(
    prog=Path(__file__).name,
    description="Pick a random image from a list of directories."
  )

  parser.add_argument('dirs', nargs='+',
    help="List of directories to search for images.")
  mode = parser.add_mutually_exclusive_group()
  mode.add_argument('-c', '--cycle', type=int,
    help="Interval (in seconds) to pick a new random image.")
  mode.add_argument('-w', '--watch', action='store_true',
    help="Keep running and set a random image on monitors added later.")
  # parser.add_argument('-o', '--outputs', nargs='+',
  #   help="List of outputs to display the image at.")
  parser.add_argument('--per-output', dest='per_output', action='store_true',
    help="Apply a random image per-output (monitor).")
  
  args = parser.parse_args()

  main(args)

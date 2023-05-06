#!/usr/bin/env python3

import time
import json
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

    if (args.per_output):
      for output in get_outputs():
        image_path: str = random.choice(images)
        subprocess.run(['swww', 'img', '--outputs', output, image_path], check=True)
    else:
      image_path: str = random.choice(images)
      subprocess.run(['swww', 'img', image_path], check=True)

    if not args.cycle:
      return

    time.sleep(args.cycle)

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
  parser.add_argument('-c', '--cycle', type=int,
    help="Interval (in seconds) to pick a new random image.")
  # parser.add_argument('-o', '--outputs', nargs='+',
  #   help="List of outputs to display the image at.")
  parser.add_argument('--per-output', dest='per_output', action='store_true',
    help="Apply a random image per-output (monitor).")
  
  args = parser.parse_args()

  main(args)

#!/usr/bin/env python3

import os
import fcntl
import contextlib
import subprocess
import json


def main():
  print(json.dumps(get_updates()))


def get_updates():
  # Run checkupdates to get a list of available package updates
  try:
    updates = subprocess.check_output(['checkupdates']).decode().splitlines()
  except subprocess.CalledProcessError as e:
    return {"text": "?"}

  # Get the number of available updates
  num_updates = len(updates)

  # Limit the number of updates shown in the tooltip to 20
  tooltip_updates = updates[:20]

  # Create a string that Waybar can understand
  data = {
      'text': num_updates,
      'tooltip': ""
  }

  # Add the tooltip to the string if there are updates available
  if num_updates > 0:
      data['tooltip'] = '\n'.join(tooltip_updates)

  # Print the JSON string
  return data


if __name__ == "__main__":
  main()

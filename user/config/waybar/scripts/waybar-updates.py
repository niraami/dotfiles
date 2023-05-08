#!/usr/bin/env python3

import re
import subprocess
import json
import collections
import typing
import math
import tempfile

from enum import Enum
from pathlib import Path


class UpdateType(Enum):
  MAJOR = 1
  MINOR = 2
  PATCH = 3
  PACKAGING = 4
  OTHER = 5


UPDATE_LABELS: typing.Final[dict[UpdateType, str]] = {
  UpdateType.MAJOR: '󰻍',
  UpdateType.MINOR: '󰀪',
  UpdateType.PATCH: '󰳤',
  UpdateType.PACKAGING: '󰏗',
  UpdateType.OTHER: '󱰌'
}


def main():
  fp = Path(tempfile.gettempdir()) / 'waybar-updates.json'

  with fp.open('w') as fd:
    json.dump(get_updates(), fd)


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

  update_type_format: str = '{} {}'
  update_type_spacing: int = 2

  # Create tooltip if any updates are available
  if num_updates > 0:
    # Categorize updates
    package_versions = [
      tuple(update.split()[i] for i in (1, 3)) for update in updates
    ]
    update_types = categorize_updates(package_versions)

    # Get length of the longest update string
    max_update_length = len(max(tooltip_updates, key=len))
    # Get length of all update type labels
    total_label_length = 0
    for t in UpdateType:
      formatted_label = update_type_format.format(
          UPDATE_LABELS[t], update_types[t]
      )
      total_label_length += len(formatted_label) + update_type_spacing

    # Calculate padding required to fit the tooltip size
    padding_length = math.ceil((max_update_length - total_label_length) / 2.0)

    # For some reason, we have to use double the padding we should need. This
    # only happens for uninterrupted spaces, if we add any other non-invisible
    # character, the normal padding amount is enough... GTK is weird.
    data['tooltip'] += ' ' * (padding_length * 2)

    for i, t in enumerate(UpdateType):
      data['tooltip'] += update_type_format.format(
          UPDATE_LABELS[t], update_types[t]
      )

      if i < len(UpdateType) - 1:
        data['tooltip'] += ' ' * update_type_spacing

    data['tooltip'] += ' ' * padding_length
    data['tooltip'] += '\n\n'
    data['tooltip'] += '\n'.join(tooltip_updates)

  return data


def categorize_updates(updates):
  counter = collections.Counter()
  for old, new in updates:
    ct = update_category(old, new)

    # DEBUG
    # print(f"{old} -> {new}: {ct}")
    counter[ct] += 1

  return counter


def update_category(old_version, new_version) -> UpdateType:
  old_epoch, old_major, old_minor, old_patch, old_packaging = \
      parse_version(old_version)
  new_epoch, new_major, new_minor, new_patch, new_packaging = \
      parse_version(new_version)

  # Epoch change could mean anything, so we'll just categorize it as a
  # packaging change, as that is what it is meant to be used as
  # NOTE: the order is important here
  if new_epoch > old_epoch:
    return UpdateType.PACKAGING
  if new_major > old_major:
    return UpdateType.MAJOR
  if new_minor > old_minor:
    return UpdateType.MINOR
  if new_patch > old_patch:
    return UpdateType.PATCH
  if new_packaging > old_packaging:
    return UpdateType.PACKAGING
  return UpdateType.OTHER


def parse_version(version):
  components = re.split(':', version)

  if len(components) > 1:
    epoch, version_str = components
  else:
    epoch, version_str = 0, components[0]

  split_version = re.split('-', version_str)

  # If the hyphen is present, set version_number to the first component and
  # packaging to the second component
  version_number, packaging = \
      split_version[0], (split_version[1] if len(split_version) > 1 else 0)

  # Split the version_number using non-digit characters and extend the list
  # with two zeros to handle missing parts
  version_parts = re.split("\D", version_number) + ["0", "0"]

  # Assign the first two components to major and minor
  major, minor = version_parts[:2]
  # Sum up all remaining elements (in case of more than 3 labels)
  patch = sum(map(int, filter(lambda x: x != '', version_parts[2:])))

  return int(epoch), int(major), int(minor), int(patch), int(packaging)


if __name__ == "__main__":
  main()

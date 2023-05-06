#!/usr/bin/env python3

import psutil
import argparse

from pathlib import Path


def main(mode: str, interval: float):
  if (mode == 'cpu'):
    print(get_cpu(interval))


def get_cpu(interval: float) -> str:
  cpu_times = psutil.cpu_times_percent(interval=interval)
  cpu_load = 100 - cpu_times[3]

  return (f"{cpu_load:.0f}")


if __name__ == '__main__':
  parser = argparse.ArgumentParser(prog=Path(__file__).name)

  parser.add_argument('mode', type=str, choices=["cpu", "mem"],
    help="Changes what information is reported.")

  parser.add_argument('interval', type=float,
    help="Refresh interval in seconds (only applicable to CPU mode).")
  args = parser.parse_args()

  main(args.mode, args.interval)

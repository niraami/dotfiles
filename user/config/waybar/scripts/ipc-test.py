#!/usr/bin/env python3

import fcntl
import os
import sys
import time

LOCK_FILE_PATH = "/run/user/1000/waybar-updates/pid"
IPC_FILE_PATH = "/run/user/1000/waybar-updates/data"


def check_lock_file():
    """
    Check if another instance of this script is already running by trying to acquire an exclusive lock on the lock file.
    If the lock file is already locked by another process, return the PID of that process. Otherwise, return None.
    """
    try:
        lock_file = open(LOCK_FILE_PATH, "w")
        fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
        # This process acquired the lock, so return None
        return None
    except IOError:
        lock_file = open(LOCK_FILE_PATH, "r")
        locked_pid = int(lock_file.read())
        return locked_pid


def write_pid_to_lock_file():
    """
    Write the PID of this process to the lock file.
    """
    with open(LOCK_FILE_PATH, "w") as lock_file:
        lock_file.write(str(os.getpid()))


def get_updates():
    """
    Perform some processing to get updates and write them to the IPC file.
    """
    with open(IPC_FILE_PATH, "w") as ipc_file:
        ipc_file.write("foo")
    time.sleep(10)  # Simulate some processing time


def main():
    # Make sure the folder for the PID lock and IPC file exists
    os.makedirs(os.path.dirname(LOCK_FILE_PATH), exist_ok=True)
    os.makedirs(os.path.dirname(IPC_FILE_PATH), exist_ok=True)

    locked_pid = check_lock_file()

    if locked_pid is None:
        # This process acquired the lock, so write its PID to the lock file
        write_pid_to_lock_file()
        updates = get_updates()
    else:
        # Another instance of this script is already running, so connect to that process via IPC and wait for the output of get_updates()
        print(f"Another instance of this script is already running with PID {locked_pid}. Waiting for updates...")
        while True:
            try:
                with open(IPC_FILE_PATH) as ipc_file:
                    updates = ipc_file.read()
                    break
            except FileNotFoundError:
                # The other process hasn't created the IPC file yet, so wait and try again
                time.sleep(1)
    print(updates)


if __name__ == "__main__":
    main()

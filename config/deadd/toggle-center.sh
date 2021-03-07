#!/usr/bin/env bash

kill -s USR1 $(pidof deadd-notification-center)
polybar-msg hook notifications 1

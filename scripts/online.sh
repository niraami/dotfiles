#!/usr/bin/env bash

gateway=$(ip r | grep default | cut -d ' ' -f 3);
ping -q -w 1 -c 1 $gateway > /dev/null && echo true || echo false;

#!/usr/bin/env bash

alias | awk -F'[ =]' '{print $2}';

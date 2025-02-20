#!/bin/bash

# This is a process management script

process=$1

if pgrep "$process" > /dev/null; then
	echo "$process is running"
else
	echo "$process is not running"
fi

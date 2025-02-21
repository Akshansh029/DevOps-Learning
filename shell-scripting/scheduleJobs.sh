#!/bin/bash

# This is a script to schedule jobs

# We will use 'at 12:05 -f ./scheduleJobs.sh' to schedule a job at a given time

file="file.txt"

echo "This new file is created at $(date)" > $file


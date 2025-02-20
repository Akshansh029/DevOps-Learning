#!/bin/bash

# This is the script to print the args in reverse order

args=("$@")
count=$#

for ((i=count-1; i>=0; i--)); do
	echo "${args[i]}"
done

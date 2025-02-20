#!/bin/bash

# This is a script for a timer

if [ $1 ]; then

	num=$1

	while [ $num -ne 0 ]; do
		echo "$num"
		num=$(($num-1))
		sleep 1
	done
	echo "Time's up!"
else
	echo "No argument was passed"
fi

#!/bin/bash

# Script to check file status and append text to it

if [ -f $1 ]; then
	echo "File is available, appending text to it..."
	echo "Appended text" >> $1
else
	touch $1
	echo "New File Created"
fi

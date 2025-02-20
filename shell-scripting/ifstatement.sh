#!/bin/bash

# This is the script for learning if statements

<<comment
read -p "Enter the number: " num

if [ $num -gt 0 ]; then
	echo "Positive number"
elif [ $num -lt 0 ]; then
	echo "Negative number"
else
	echo "Number is 0"
fi
comment

read -p "Enter the file name: " file

if [ -f "$file" ]; then
	echo "File is present, opening the file"
	cat $file
else
	echo "File is not present, creating the file"
	touch $file
fi

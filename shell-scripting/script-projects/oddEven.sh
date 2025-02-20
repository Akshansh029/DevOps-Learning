#!/bin/bash

# This is a script to check if the arg is odd or even

if [ $(( $1 % 2 )) -eq 0 ]; then
	echo "Even number"
else
	echo "Odd number"
fi



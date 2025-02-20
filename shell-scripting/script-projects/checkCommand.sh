#!/bin/bash

# This is a script to check if the command is present or not

read -p "Enter the command: " comm

if command -v $comm; then
	echo "Command is available, running the command..."
else
	echo "Command is not available, installing it..."
	sudo apt update && sudo apt -y $comm
fi

$comm

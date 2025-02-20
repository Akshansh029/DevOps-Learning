#!/bin/bash

# This is a script to create a user

read -p "Enter the username to be created: " username

sudo useradd -m $username

echo "$username added as user"

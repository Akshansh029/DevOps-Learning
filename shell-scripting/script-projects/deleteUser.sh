#!/bin/bash

# This is the script to delete the user

read -p "Enter user to be deleted: " username

sudo userdel $username

echo "$username is deleted from users list"

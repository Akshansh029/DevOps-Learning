#!/bin/bash

# This is a script to make a todo list

if [ -f "todo.txt" ]; then
    read -p "Enter a task: " task
    echo "$task" >> todo.txt
    echo "Task added successfully!"
    echo "List of tasks: "
    cat todo.txt
else
    touch todo.txt
    read -p "Enter a task: " task
    echo "$task" >> todo.txt
    echo "Task added successfully!"
    echo "List of tasks: "
    cat todo.txt
fi

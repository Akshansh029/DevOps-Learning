#!/bin/bash

# This is a script for a simple calculator

var=0

while [ $var -ne 1 ]; do
read -p "Enter first number: " num1
read -p "Enter second number: " num2
read -p "Enter the operation (type 'exit' to stop): " operator

case $operator in
    "+") echo "Sum = $(($num1+$num2))";;
    "-") echo "Difference = $(($num1-$num2))";;
    "*") echo "Product = $(($num1*$num2))";;
    "/")
    if [ "$num2" -eq 0 ]; then
        echo "Error: Division by zero!"
    else
	result=$(echo "scale=2; $num1/$num2" | bc)
        echo "Result: $result"
    fi
    ;;
    "exit") var=1;;
    *) echo "Invalid operator! Please try again";;
esac
done

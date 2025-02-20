#!/bin/bash

# This is the script for functions

greet() {
	echo "Hello, $1!"
}

sum() {
	sum=$(($1+$2))
	echo "Sum: $sum"
}

greet "Akshansh"
sum 20 30

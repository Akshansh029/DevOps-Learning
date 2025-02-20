#!/bin/bash

# This is the script for For Loop

<< comment
for num in {1..10}; do
	echo $num
	sleep 0.5
done

echo "Loop completed"
comment

<< comment1
mkdir logfiles

cp /var/log/*.log logfiles
ls logfiles

for file in logfiles/*.log; do
	tar -cvzf $file.tar.gz $file
done

echo "Directory created"
echo "Files copied"
echo "Files compressed"
comment1

for ((num=1; num<=5; num++));
do
	mkdir "demo$num"
done

echo "All directory done"

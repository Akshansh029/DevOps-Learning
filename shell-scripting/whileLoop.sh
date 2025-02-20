#!/bin/bash

# While loops

<< comment
var=1

while [ $var -le 10 ]; do
	echo $var
	var=$(( var + 1 ))
	sleep 0.5
done

echo "Loop is finished"
comment

while read -p "Enter something (type 'exit' to stop): " input; do
	if [ "$input" = "exit" ]; then
		echo "Exiting..."
		break
	else
		echo "You entered: $input"
	fi
done

#!/bin/bash

<< readme
This is a script for backup with 5 day rotation

Usage:
./backup.sh <path to your source> <path to backup folder>
readme

display_usage() {
    echo "Usage: ./backup.sh <path to your source> <path to backup folder>"
}

if [[ $# -ne 2 ]]; then
    display_usage
fi

source_dir=$1
dest_dir=$2
time_stamp=$(date '+%Y-%m-%d-%H-%M-%S')

create_backup() {
    zip -r -j "${dest_dir}/backup_${time_stamp}.zip" "${source_dir}" > /dev/null

    if [ $? -eq 0 ]; then
        echo "Backup generated successfully for ${time_stamp}"
    else
	echo "Backup not created dur to some error"
	exit 1
    fi
}

perform_rotation() {
    # Creating array of all backup zip files
    # Outer paranthesis is create array
    backups=($(ls -t "${dest_dir}/backup_"*.zip 2> /dev/null))

    if [ "${#backups[@]}" -gt 5 ]; then # The '#' is to get the length of the array
	echo "Performing rotation for 5 days"

	# Extracting zip files after 5th index from the array
	backups_to_remove=("${backups[@]:5}")

	# Removing each zip file in the backups_to_remove array
	for backup in "${backups_to_remove[@]}"; do
	    rm -f ${backup}
	done
    fi
}

create_backup
perform_rotation

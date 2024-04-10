#!/bin/bash

backup_dir="/path/to/source/directory"
backup_dest="/path/to/backup/location"
backup_date=$(date +"%Y-%m-%d")
backup_file="backup_$backup_date.tar.gz"

tar -czf "$backup_dest/$backup_file" "$backup_dir"

if [ $? -eq 0 ]; then
    echo "Backup created successfully: $backup_dest/$backup_file"
else
    echo "ERROR: Backup creation failed."
fi

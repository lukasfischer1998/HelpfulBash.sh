#!/bin/bash

backup_dir="/pfad/zum/zu/sichernden/verzeichnis"
backup_dest="/pfad/zum/sicherungsspeicherort"
backup_date=$(date +"%Y-%m-%d")
backup_file="backup_$backup_date.tar.gz"

tar -czf "$backup_dest/$backup_file" "$backup_dir"

if [ $? -eq 0 ]; then
    echo "Sicherung erfolgreich erstellt: $backup_dest/$backup_file"
else
    echo "FEHLER: Sicherung konnte nicht erstellt werden."
fi

#!/bin/bash

check_bc_installed() {
    if ! command -v bc &> /dev/null; then
        echo "WARNUNG: Das Programm 'bc' ist nicht installiert. Bitte installieren Sie es, um dieses Skript auszuführen."
        exit 1
    fi
}

check_cpu_usage() {
    cpu_threshold=80
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "Aktuelle CPU-Auslastung: $cpu_usage%"
    if [ $(echo "$cpu_usage > $cpu_threshold" | bc) -eq 1 ]; then
        echo "WARNUNG: Hohe CPU-Auslastung - $cpu_usage%"
    fi
}

check_disk_space() {
    disk_threshold=90
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Freier Festplattenspeicher: $disk_usage%"
    if [ $disk_usage -ge $disk_threshold ]; then
        echo "WARNUNG: Geringer freier Speicherplatz auf der Festplatte - $disk_usage%"
    fi
}

check_logged_in_users() {
    max_users=10
    current_users=$(who | wc -l)
    echo "Aktuell eingeloggte Benutzer: $current_users"
    if [ $current_users -gt $max_users ]; then
        echo "WARNUNG: Übermäßige Anzahl eingeloggter Benutzer - $current_users"
    fi
}

main() {
    echo "===== Systemüberwachung starten $(date) ====="
    check_bc_installed
    check_cpu_usage
    check_disk_space
    check_logged_in_users
    echo "===== Systemüberwachung beendet ====="
}

main

#!/bin/bash

check_bc_installed() {
    if ! command -v bc &> /dev/null; then
        echo "WARNING: The 'bc' program is not installed. Please install it to execute this script."
        exit 1
    fi
}

check_cpu_usage() {
    cpu_threshold=80
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "Current CPU Usage: $cpu_usage%"
    if [ $(echo "$cpu_usage > $cpu_threshold" | bc) -eq 1 ]; then
        echo "WARNING: High CPU usage - $cpu_usage%"
    fi
}

check_disk_space() {
    disk_threshold=90
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Free Disk Space: $disk_usage%"
    if [ $disk_usage -ge $disk_threshold ]; then
        echo "WARNING: Low free disk space - $disk_usage%"
    fi
}

check_logged_in_users() {
    max_users=1
    current_users=$(who | wc -l)
    echo "Currently logged in users: $current_users"
    if [ $current_users -gt $max_users ]; then
        echo "WARNING: Excessive number of logged in users - $current_users"
    fi
}

main() {
    echo "===== System monitoring started $(date) ====="
    check_bc_installed
    check_cpu_usage
    check_disk_space
    check_logged_in_users
    echo "===== System monitoring completed ====="
}

main

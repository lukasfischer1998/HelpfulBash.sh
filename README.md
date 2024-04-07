# Helpful Server Scripts

This repository contains a collection of useful Bash scripts for Linux server system administration and some of them surely can be used for normal Linux systems.


![Bash Logo](https://bashlogo.com/img/logo/svg/full_colored_dark.svg)

## Automatic Update Script
The automatic update script performs automatic security updates for the operating system and installed software. It runs regularly to ensure the system is always up to date.

## System Monitoring Script
The system monitoring script checks the system state to detect resource shortages or errors, and takes appropriate actions or generates warnings. It monitors CPU usage, free disk space, and the number of logged-in users.

## Backup Script
The backup script enables regular backups of important databases, files, or configurations, storing them in a secure location. It can be easily customized to perform various types of backups. I will implement an function to send youre backup to google drive or smth.


## File Search Script
This Bash script allows you to search for files in a specified directory that contain a particular string. `./searchforfile.sh <directory> <search_string>`

### Making it Default and Setting Up Automatic Execution
To make the automatic update script a standard process and have it executed regularly at a specific time, you can set up a cron job. Open the cron table using the command `crontab -e` and add the following line:
`0 2 * * * /path/to/script/auto_update.sh` This will execute the script daily at 2:00 AM. Make sure to replace "/path/to/script/auto_update.sh" with the actual path to your automatic update script.

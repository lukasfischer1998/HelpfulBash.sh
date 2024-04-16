# Helpful Server Scripts

This repository contains a collection of useful Bash scripts for Linux server system administration and some of them surely can be used for normal Linux systems.

![Bash Logo](https://bashlogo.com/img/logo/svg/full_colored_dark.svg)

## Table of Contents
- [Helpful Server Scripts](#helpful-server-scripts)
  - [Table of Contents](#table-of-contents)
  - [Automatic Update Script](#automatic-update-script)
  - [System Monitoring Script](#system-monitoring-script)
  - [Backup Script](#backup-script)
  - [File Search Script](#file-search-script)
  - [Vim Installation and Configuration Script](#vim-installation-and-configuration-script)
  - [loginlog Script](#loginlog-script)
  - [User Management Script](#user-management-script)
  - [HeisseFeed Script](#heissefeed-script)
    - [Making it Default and Setting Up Automatic Execution](#making-it-default-and-setting-up-automatic-execution)

## Automatic Update Script
The automatic update script performs automatic security updates for the operating system and installed software. It runs regularly to ensure the system is always up to date.

## System Monitoring Script
The system monitoring script checks the system state to detect resource shortages or errors, and takes appropriate actions or generates warnings. It monitors CPU usage, free disk space, and the number of logged-in users.

## Backup Script
The backup script enables regular backups of important databases, files, or configurations, storing them in a secure location. It can be easily customized to perform various types of backups. I will implement a function to send your backup to Google Drive or something similar.

## File Search Script
This Bash script allows you to search for files in a specified directory that contain a particular string. `./searchforfile.sh <directory> <search_string>`

## Vim Installation and Configuration Script
This Bash script automates the installation of Vim and sets up its configuration for the current logged-in user. The configurations are just some changes in the logged-in user's vimrc. Run the script with root privileges using `sudo ./install_vim.sh`.

## loginlog Script
This Bash script monitors login activities on a Linux server and saves them to a specified log file. To use, simply adjust the LOG_FILE variable to the desired location and run the script, which will continuously monitor login events and append them to the specified log file. For Debian-based systems like Ubuntu and Debian, the common path for authentication logs is /var/log/auth.log. For CentOS and Fedora, it's /var/log/secure. Older Ubuntu versions also use /var/log/auth.log, while macOS typically stores authentication logs in /var/log/system.log.

## User Management Script
This script facilitates user management tasks such as creating, deleting, locking, and modifying user attributes.

## HeisseFeed Script
The `heissefeed.sh` script fetches and formats RSS feed content from the Heise website. It extracts titles and descriptions, formatting them alternately. If `xmlstarlet` is not installed, it will be installed automatically. 




### Making it Default and Setting Up Automatic Execution
To make the automatic update script a standard process, open the cron table using the command `crontab -e` and add the following line:
`0 2 * * * /path/to/script/SCRIPTNAME` This will execute the script daily at 2:00 AM. For example.

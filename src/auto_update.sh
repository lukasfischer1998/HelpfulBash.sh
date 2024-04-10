#!/bin/bash

# Update/upgrade system 
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y


sudo apt autoremove -y
sudo apt clean

# Log security updates
echo "Security updates were installed on $(date)" >> /var/log/security_updates.log
echo "Script completed successfully."

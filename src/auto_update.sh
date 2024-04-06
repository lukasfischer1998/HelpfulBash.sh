#!/bin/bash


sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt clean

echo "Sicherheitsupdates wurden am $(date) installiert" >> /var/log/security_updates.log

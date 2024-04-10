#!/bin/bash

# Check root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with root privileges."
    exit 1
fi

# Install Neovim
apt update
apt install -y neovim

# Check installation
if command -v nvim &>/dev/null; then
    echo "Neovim has been installed successfully."
else
    echo "Error installing Neovim."
    exit 1
fi

# Change to the user's home directory
user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)
if [ -z "$user_home" ]; then
    echo "Error: Unable to determine user's home directory."
    exit 1
fi
cd "$user_home" || exit

# Clone Neovim configuration from https://github.com/jdhao/nvim-config
sudo -u "$SUDO_USER" git clone https://github.com/jdhao/nvim-config .config/nvim

# Check clone
if [ -d "$user_home/.config/nvim" ]; then
    echo "Neovim configuration has been installed successfully."
else
    echo "Error cloning Neovim configuration."
    exit 1
fi

# Set permissions
chown -R "$SUDO_USER":"$SUDO_USER" "$user_home/.config/nvim"

echo "Finished!"
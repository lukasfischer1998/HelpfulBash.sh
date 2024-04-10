#!/bin/bash

# Check root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with root privileges."
    exit 1
fi

# Function to install prerequisites
install_prerequisites() {
    #Python and pip
    apt update
    apt install -y python3 python3-pip

    # Node.js a npm
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    apt install -y nodejs

    # Python packages
    pip3 install pynvim flake8 black isort
}

# install Neovim & config
install_neovim() {
   
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

    echo "Finished installing Neovim!"
}

# Function to uninstall Neovim and configuration
uninstall_neovim() {
    # Remove Neovim and its configuration
    apt remove -y neovim
    rm -rf "$user_home/.config/nvim"

    # Remove installed Python packages
    pip3 uninstall -y pynvim flake8 black isort

    echo "Neovim, its configuration, and related packages have been uninstalled successfully."
}
# Ask user whether to install or uninstall Neovim
read -p "Do you want to install or uninstall Neovim? (install/uninstall): " choice

case "$choice" in
    install)
        install_prerequisites
        install_neovim
        ;;
    uninstall)
        uninstall_neovim
        ;;
    *)
        echo "Invalid choice. Please specify 'install' or 'uninstall'."
        exit 1
        ;;
esac

exit 0

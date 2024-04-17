#!/bin/bash
# Check if script is run with sudo privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges. Please run it with sudo."
    exit 1
fi

# Function to install Vim
install_vim() {
    echo "Installing Vim..."
    apt-get update
    apt-get install vim -y
    echo "Vim has been successfully installed."
}

# Function to remove Vim directories in user's home directory
uninstall_vim_dirs() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    echo "Removing .vim directory and subdirectories in the home directory of $SUDO_USER..."
    rm -rf "$user_home/.vim"
    echo "Directories have been successfully removed."
}

# Function to delete .vimrc file in user's home directory
delete_vimrc() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    echo "Deleting .vimrc file in the home directory of $SUDO_USER..."
    rm -f "$user_home/.vimrc"
    echo ".vimrc file has been successfully deleted."
}

# Function to update .vimrc file with a modern Vim setup
update_vimrc_file() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    local vimrc_path="$user_home/.vimrc"
    echo "Updating .vimrc file in the home directory of $SUDO_USER..."

    # Create a modern .vimrc file
    cat <<EOT > "$vimrc_path"
" Modernes Vim-Setup

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Enable mouse support (if available)
if has('mouse')
  set mouse=a
endif

" Enable clipboard support (if available)
if has('clipboard')
  set clipboard=unnamedplus
endif

" Enable persistent undo
set undofile
set undodir=~/.vim/undodir

" Enable line wrapping
set wrap

" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Set colorscheme (change 'desert' to your preferred colorscheme)
colorscheme slate

" Define leader key
let mapleader = "\<Space>"

" Map keys for easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Auto save files
set autowrite

" Enable wildmenu for command line completion
set wildmenu

" Enable incremental search
set incsearch

" Show matching parentheses
set showmatch

" Highlight current line
set cursorline
EOT

    echo ".vimrc file has been successfully updated."
}

# Main function to uninstall Vim
uninstall_vim() {
    echo "Uninstalling Vim..."
    apt-get remove vim -y
    apt-get remove --purge vim -y
    apt-get autoremove -y
    aptitude remove vim -y
    uninstall_vim_dirs
    delete_vimrc
    echo "Vim has been successfully uninstalled."
}

# Main function to install and configure Vim
main() {
    # Ask user whether to install or uninstall
    echo "Do you want to install or uninstall Vim?"
    echo "  i) Install"
    echo "  u) Uninstall"
    read -p "Your choice: " choice

    case $choice in
        i|I)
            install_vim
            update_vimrc_file
            ;;
        u|U)
            uninstall_vim
            ;;
        *)
            echo "Invalid choice. Please choose 'i' to install or 'u' to uninstall."
            ;;
    esac
}

# Call the main function
main

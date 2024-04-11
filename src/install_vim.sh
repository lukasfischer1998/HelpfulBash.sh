#!/bin/bash

# Überprüfen, ob das Skript mit sudo-Rechten ausgeführt wird
if [ "$(id -u)" != "0" ]; then
    echo "Dieses Skript benötigt sudo-Rechte. Bitte führen Sie es mit sudo aus."
    exit 1
fi

# Funktion zur Installation von Vim
install_vim() {
    echo "Vim wird installiert..."
    apt-get update
    apt-get install vim -y
    echo "Vim wurde erfolgreich installiert."
}

# Funktion zum Entfernen der Verzeichnisse für Vim im Home-Verzeichnis des aktuellen Benutzers
uninstall_vim_dirs() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    echo "Entferne .vim-Verzeichnis und Unterverzeichnisse im Home-Verzeichnis von $SUDO_USER..."
    rm -rf "$user_home/.vim"
    echo "Verzeichnisse wurden erfolgreich entfernt."
}

# Funktion zum Entfernen der .vimrc-Datei im Home-Verzeichnis des aktuellen Benutzers
delete_vimrc() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    echo "Entferne .vimrc-Datei im Home-Verzeichnis von $SUDO_USER..."
    rm -f "$user_home/.vimrc"
    echo ".vimrc-Datei wurde erfolgreich entfernt."
}

# Funktion zum Aktualisieren der .vimrc-Datei mit einem modernen Vim-Setup
update_vimrc_file() {
    local user_home=$(getent passwd $SUDO_USER | cut -d: -f6)
    local vimrc_path="$user_home/.vimrc"
    echo "Aktualisiere .vimrc-Datei im Home-Verzeichnis von $SUDO_USER..."

    # Erstelle eine moderne .vimrc-Datei
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

    echo "Die .vimrc-Datei wurde erfolgreich aktualisiert."
}

# Hauptfunktion zum Deinstallieren von Vim
uninstall_vim() {
    echo "Vim wird deinstalliert..."
    apt-get remove vim -y
    apt-get remove --purge vim -y
    apt-get autoremove -y
    aptitude remove vim -y
    uninstall_vim_dirs
    delete_vimrc
    echo "Vim wurde erfolgreich deinstalliert."
}

# Hauptfunktion zum Installieren und Konfigurieren von Vim
main() {
    # Benutzer fragen, ob installiert oder deinstalliert werden soll
    echo "Möchten Sie Vim installieren oder deinstallieren? (i für installieren, d für deinstallieren)"
    read choice

    case $choice in
        i)
            install_vim
            update_vimrc_file
            ;;
        d)
            uninstall_vim
            ;;
        *)
            echo "Ungültige Auswahl. Bitte wählen Sie 'i' für installieren oder 'd' für deinstallieren."
            ;;
    esac
}

# Aufrufen der Hauptfunktion
main

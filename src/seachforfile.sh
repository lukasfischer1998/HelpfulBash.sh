#!/bin/bash

search_files() {
    local directory="$1"
    local search_string="$2"
    
    find "$directory" -type f -exec grep -l "$search_string" {} +
}

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <search_string>"
    exit 1
fi

directory="$1"
search_string="$2"

if [ ! -d "$directory" ]; then
    echo "Directory '$directory' not found."
    exit 1
fi

echo "Searching for files containing '$search_string' in $directory ..."
search_files "$directory" "$search_string"


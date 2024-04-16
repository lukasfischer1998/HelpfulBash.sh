#!/bin/bash

# Color codes
BLUE='\033[0;34m'
OTHER_COLOR='\033[0;32m'
NC='\033[0m' # No Color

# Check sudo
check_sudo() {
    if ! command -v xmlstarlet >/dev/null; then
        if [ "$(id -u)" != "0" ]; then
            echo "This script requires sudo for xmlstarlet. Please run with sudo."
            exit 1
        fi
    fi
}

# Install xmlstarlet if needed
install_xmlstarlet() {
    if ! command -v xmlstarlet >/dev/null; then
        echo "Installing xmlstarlet..."
        if command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y xmlstarlet
        elif command -v yum >/dev/null; then sudo yum install -y xmlstarlet
        elif command -v brew >/dev/null; then brew install xmlstarlet
        else echo "Cannot install xmlstarlet. Please install it manually."; exit 1; fi
    fi
}

check_sudo
install_xmlstarlet

# RSS Feed URL
FEED_URL="https://www.heise.de/rss/heise.rdf"
CURRENT_COLOR="$BLUE"

# Fetch and process feed
while IFS= read -r line; do
    if [ "$CURRENT_COLOR" == "$BLUE" ]; then
        # Blue title
        echo -e "${BLUE}$line${NC}" | sed '/^[[:space:]]*$/d'
        CURRENT_COLOR="$OTHER_COLOR"  # Switch color
    else
        # Green description
        echo -e "${OTHER_COLOR}$line${NC}" | sed '/^[[:space:]]*$/d'
        CURRENT_COLOR="$BLUE"  # Switch back to blue
    fi
done <<EOF
$(curl -s "$FEED_URL" | \
xmlstarlet sel -t -m "//item" -v "title" -o $'\n' \
                            -v "description" -o $'\n\n')
EOF

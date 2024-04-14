#!/bin/bash

# Create a user
create_user() {
    read -p "Enter username: " username
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        adduser "$username"
        echo "User $username created."
    fi
}

# Delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        echo "User $username deleted."
    else
        echo "User $username does not exist."
    fi
}

# Lock a user
lock_user() {
    read -p "Enter username to lock: " username
    if id "$username" &>/dev/null; then
        passwd -l "$username"
        echo "User $username locked."
    else
        echo "User $username does not exist."
    fi
}

# Modify user attributes
modify_user() {
    read -p "Enter username to modify: " username
    if id "$username" &>/dev/null; then
        read -p "Enter new shell for $username (leave blank to skip): " new_shell
        if [ -n "$new_shell" ]; then
            usermod -s "$new_shell" "$username"
            echo "Shell for user $username changed to $new_shell."
        fi

        read -p "Enter new home directory for $username (leave blank to skip): " new_home
        if [ -n "$new_home" ]; then
            usermod -d "$new_home" "$username"
            echo "Home directory for user $username changed to $new_home."
        fi
    else
        echo "User $username does not exist."
    fi
}

# Main menu
while true; do
    echo "User Management Menu:"
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Lock User"
    echo "4. Modify User"
    echo "5. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) create_user ;;
        2) delete_user ;;
        3) lock_user ;;
        4) modify_user ;;
        5) echo "Exiting."; exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 5." ;;
    esac
done

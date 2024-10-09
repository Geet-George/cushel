#!/bin/bash

# Get the directory where this script is located
script_dir=$(dirname "$(realpath "$0")")

# Define the path to the .cushel file relative to the script directory
cushel_path="$script_dir/.cushel"

# Check if the .cushel file exists
if [ ! -f "$cushel_path" ]; then
    echo "Error: .cushel file does not exist at $cushel_path"
    exit 1
fi

# Allow user to provide a custom .bashrc path, default to ~/.bashrc if not provided
bashrc_path="${1:-}"

# Function to add cushel to a given file
add_cushel_to_file() {
    local file_path="$1"
    local lines_to_add="
# Import cushel
cushel_path=\"$cushel_path\"
if [ -f \"\$cushel_path\" ]; then
    . \"\$cushel_path\"
fi
"
    # Check if the key part of the lines is already in the file
    if ! grep -qF "cushel_path=\"$cushel_path\"" "$file_path"; then
        # If not found, append the lines to the file
        echo "$lines_to_add" >> "$file_path"
        echo "Successfully added to $file_path. Please restart your terminal or run 'source $file_path' to apply changes."
    else
        echo "The cushel setup is already present in $file_path. If you don't see expected changes, you might have forgotten to activate the settings. To do so, please restart your terminal or run 'source $file_path' and the changes should be applied."
    fi
}

# If no custom .bashrc path is provided
if [ -z "$bashrc_path" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        read -p "Should I add cushel to .bashrc? (y/n): " response
        if [[ "$response" == "y" ]]; then
            bashrc_path="$HOME/.bashrc"
            # Create a backup of .bashrc before making any changes
            backup_path="${bashrc_path}.bak_$(date +%Y%m%d_%H%M%S)"
            cp "$bashrc_path" "$backup_path"
            echo "Backup of .bashrc created at $backup_path"
        fi
    elif [ -f "$HOME/.bash_profile" ]; then
        read -p "No .bashrc found. Should I add cushel to .bash_profile? If you respond with 'n' you will be presented with the option of adding cushel to a newly created .bashrc which will be sourced from .bash_profile : " response
        if [[ "$response" == "y" ]]; then
            bashrc_path="$HOME/.bash_profile"
        else
            read -p "Should I create a .bashrc, add cushel to it, and source it from .bash_profile? (y/n): " response
            if [[ "$response" == "y" ]]; then
                bashrc_path="$HOME/.bashrc"
                echo "source ~/.bashrc" >> "$HOME/.bash_profile"
                echo "Added 'source ~/.bashrc' to .bash_profile"
            else
                echo "No changes made."
                exit 0
            fi
        fi
    else
        read -p "No .bashrc or .bash_profile found. Should I create a .bashrc and add cushel to it? (y/n): " response
        if [[ "$response" == "y" ]]; then
            bashrc_path="$HOME/.bashrc"
        else
            echo "No changes made."
            exit 0
        fi
    fi
else
    # Check if the provided .bashrc file exists
    if [ ! -f "$bashrc_path" ]; then
        echo "Error: Provided .bashrc file does not exist at $bashrc_path"
        exit 1
    else
        backup_path="${bashrc_path}.bak_$(date +%Y%m%d_%H%M%S)"
        cp "$bashrc_path" "$backup_path"
        echo "Backup of .bashrc created at $backup_path"
    fi
fi


# Add cushel to the selected file
add_cushel_to_file "$bashrc_path"
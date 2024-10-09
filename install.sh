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
bashrc_path="${1:-$HOME/.bashrc}"

# Check if the provided .bashrc file exists
if [ ! -f "$bashrc_path" ]; then
    echo "Error: .bashrc file does not exist at $bashrc_path"
    exit 1
fi

# Create a backup of .bashrc before making any changes
backup_path="${bashrc_path}.bak_$(date +%Y%m%d_%H%M%S)"
cp "$bashrc_path" "$backup_path"
echo "Backup of .bashrc created at $backup_path"

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

# Add cushel to the selected file
add_cushel_to_file "$bashrc_path"
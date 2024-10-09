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

# Define the lines to add to the .bashrc file
lines_to_add="
# Import cushel
cushel_path=\"$cushel_path\"
if [ -f \"\$cushel_path\" ]; then
    . \"\$cushel_path\"
fi
"

# Check if the key part of the lines is already in .bashrc (check if cushel_path line exists)
if ! grep -qF "cushel_path=\"$cushel_path\"" "$bashrc_path"; then
    # If not found, append the lines to .bashrc
    echo "$lines_to_add" >> "$bashrc_path"
    echo "Successfully added to $bashrc_path. Please restart your terminal or run 'source $bashrc_path' to apply changes."
else
    echo "The cushel setup is already present in $bashrc_path. If you don't see expected changes, you might have forgotten to activate the settings. To do so, please restart your terminal or run 'source $bashrc_path' and the changes should be applied."
fi


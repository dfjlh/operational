#!/bin/bash

# Prompt the user for the file name
read -p "Enter the file name: " filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File '$filename' not found."
    exit 1
fi

# Prompt the user for sed patterns and commands
read -p "Enter the sed pattern to remove lines shorter than: " pattern_length
read -p "Do you want to remove lines without special characters? (yes/no): " remove_special
read -p "Enter the sed pattern to remove lines without numbers: " pattern_numbers

# Perform the sed commands based on user input
sed -ri "/$pattern_length/d" "$filename"
if [[ $remove_special == "yes" ]]; then
    sed -ri '/[^[:alnum:][:space:]]/!d' "$filename"
fi
sed -ri "/$pattern_numbers/!d" "$filename"

echo "Wordlist updated successfully."

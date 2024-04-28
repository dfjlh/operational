#!/bin/bash

# Check if a filename is provided as an argument
if [ $# -eq 0 ]; then
  echo "Error: Please provide a filename as an argument."
  echo "Usage: $0 <filename>"
  exit 1
fi

# Store the filename from the first argument
filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "File '$filename' not found."
  exit 1
fi

# Prompt the user for sed patterns and commands
read -p "Do you want to remove lines without special characters? (yes/no): " remove_special
read -p "Enter the sed pattern to remove lines without numbers: " pattern_numbers

# Perform the sed commands based on user input
sed -ri "/$pattern_length/d" "$filename"
if [[ $remove_special == "yes" ]]; then
  sed -ri '/[^[:alnum:][:space:]]/!d' "$filename"
fi
sed -ri "/$pattern_numbers/!d" "$filename"

echo "Wordlist updated successfully."

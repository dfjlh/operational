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

# Prompt the user for removing special characters and password length
read -p "Do you want to remove lines without special characters? (yes/no): " remove_special

# Get user input for password length (handle non-numeric input)
read -p "Enter the minimum password length (numbers only): " min_length
if [[ ! $min_length =~ ^[0-9]+$ ]]; then
  echo "Error: Please enter a valid number for minimum password length."
  exit 1
fi

# Perform sed commands based on user input
if [[ $remove_special == "yes" ]]; then
  sed -ri '/[^[:alnum:][:space:]]/!d' "$filename"
fi

# Remove lines with password shorter than the provided length
sed -ri "/^.{0,$((min_length-1))}$/d" "$filename"

echo "Wordlist updated successfully."

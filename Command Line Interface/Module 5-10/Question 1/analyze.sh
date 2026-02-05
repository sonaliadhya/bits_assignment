#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Error: Please provide exactly one argument."
  exit 1
fi

path=$1

if [ ! -e "$path" ]; then
  echo "Error: The specified path does not exist."
  exit 1
fi

# If it's a file
if [ -f "$path" ]; then
  echo "Its a file: $path"
  echo "Number of lines: $(wc -l < "$path")"
  echo "Number of words: $(wc -w < "$path")"
  echo "Number of characters: $(wc -m < "$path")"

# If it's a directory
elif [ -d "$path" ]; then
  echo "Its a directory: $path"
  total_files=$(find "$path" -type f | wc -l)
  txt_files=$(find "$path" -type f -name "*.txt" | wc -l)
  echo "Total number of files: $total_files"
  echo "Number of .txt files: $txt_files"

# If it's neither
else
  echo "Error: Argument is neither a file nor a directory."
  exit 1
fi

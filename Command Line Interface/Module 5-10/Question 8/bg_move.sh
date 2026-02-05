#!/bin/bash

# Check argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIR="$1"

# Validate directory
if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

BACKUP_DIR="$DIR/backup"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Script PID (parent process): $$"
echo

# Move each file in background
for file in "$DIR"/*
do
    # Skip the backup directory itself
    if [ "$file" = "$BACKUP_DIR" ]; then
        continue
    fi

    if [ -f "$file" ]; then
        mv "$file" "$BACKUP_DIR/" &
        pid=$!
        echo "Moving $(basename "$file") in background. PID: $pid"
    fi
done

echo
echo "Waiting for all background processes to finish..."
wait

echo "All background move operations completed."

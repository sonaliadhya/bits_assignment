#!/bin/bash

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 dirA dirB"
    exit 1
fi

DIRA="$1"
DIRB="$2"

# Validate directories
if [ ! -d "$DIRA" ]; then
    echo "Error: '$DIRA' is not a directory."
    exit 1
fi

if [ ! -d "$DIRB" ]; then
    echo "Error: '$DIRB' is not a directory."
    exit 1
fi

echo "Files only in $DIRA:"
echo "---------------------"
ls "$DIRA" | while read -r file
do
    if [ ! -e "$DIRB/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files only in $DIRB:"
echo "---------------------"
ls "$DIRB" | while read -r file
do
    if [ ! -e "$DIRA/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files present in BOTH directories but with different contents:"
echo "--------------------------------------------------------------"

ls "$DIRA" | while read -r file
do
    if [ -f "$DIRA/$file" ] && [ -f "$DIRB/$file" ]; then
        # Compare file contents silently
        cmp -s "$DIRA/$file" "$DIRB/$file"
        if [ "$?" -ne 0 ]; then
            echo "$file"
        fi
    fi
done

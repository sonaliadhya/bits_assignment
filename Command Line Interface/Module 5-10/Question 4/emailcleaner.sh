#!/bin/bash

# Check if emails.txt exists and is readable
if [ ! -f "emails.txt" ] || [ ! -r "emails.txt" ]; then
    echo "Error: emails.txt file not found or not readable."
    exit 1
fi

# Regular expression for valid email:
# letters and digits only, followed by @, letters only, ending with .com
VALID_REGEX='^[a-zA-Z0-9]\+@[a-zA-Z]\+\.com$'

# Extract valid email addresses, remove duplicates
grep "$VALID_REGEX" emails.txt | sort | uniq > valid.txt

# Extract invalid email addresses
grep -v "$VALID_REGEX" emails.txt > invalid.txt

echo "Email cleaning completed."
echo "Valid emails saved to valid.txt"
echo "Invalid emails saved to invalid.txt"

#!/bin/bash

# Check input file
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <inputfile>"
    exit 1
fi

INPUT="$1"

if [ ! -f "$INPUT" ] || [ ! -r "$INPUT" ]; then
    echo "Error: File not found or not readable."
    exit 1
fi

# Convert text to one word per line, lowercase everything
WORDS=$(tr -c '[:alpha:]' '\n' < "$INPUT" | tr 'A-Z' 'a-z' | grep -v '^$')

# Words containing ONLY vowels
echo "$WORDS" | grep -E '^[aeiou]+$' > vowels.txt

# Words containing ONLY consonants
echo "$WORDS" | grep -E '^[bcdfghjklmnpqrstvwxyz]+$' > consonants.txt

# Words containing BOTH vowels and consonants AND starting with a consonant
echo "$WORDS" | grep -E '^[bcdfghjklmnpqrstvwxyz]' \
              | grep -E '[aeiou]' \
              | grep -E '[bcdfghjklmnpqrstvwxyz]' > mixed.txt

echo "Pattern extraction completed."
echo "vowels.txt, consonants.txt, and mixed.txt created."

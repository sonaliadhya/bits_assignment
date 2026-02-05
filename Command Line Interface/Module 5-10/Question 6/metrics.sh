#!/bin/bash

# Check if input.txt exists and is readable
if [ ! -f "input.txt" ] || [ ! -r "input.txt" ]; then
    echo "Error: input.txt file not found or not readable."
    exit 1
fi

# Convert text to one word per line (lowercase, remove punctuation)
WORDS=$(tr -c '[:alnum:]' '\n' < input.txt | tr 'A-Z' 'a-z' | grep -v '^$')

# Longest word
LONGEST=$(echo "$WORDS" | awk '{ print length, $0 }' | sort -nr | head -1 | cut -d' ' -f2-)

# Shortest word
SHORTEST=$(echo "$WORDS" | awk '{ print length, $0 }' | sort -n | head -1 | cut -d' ' -f2-)

# Average word length
TOTAL_LEN=$(echo "$WORDS" | awk '{ sum += length } END { print sum }')
TOTAL_WORDS=$(echo "$WORDS" | wc -l)
AVG_LEN=$(awk "BEGIN { printf \"%.2f\", $TOTAL_LEN / $TOTAL_WORDS }")

# Total number of unique words
UNIQUE_COUNT=$(echo "$WORDS" | sort | uniq | wc -l)

# Display results
echo "Text Metrics"
echo "------------"
echo "Longest word           : $LONGEST"
echo "Shortest word          : $SHORTEST"
echo "Average word length    : $AVG_LEN"
echo "Total unique words     : $UNIQUE_COUNT"

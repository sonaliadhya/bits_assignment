#!/bin/bash

# Check if marks.txt exists and is readable
if [ ! -f "marks.txt" ] || [ ! -r "marks.txt" ]; then
    echo "Error: marks.txt file not found or not readable."
    exit 1
fi

fail_one_count=0
pass_all_count=0

echo "Students who failed in exactly ONE subject:"
echo "-------------------------------------------"

# Read file line by line
while IFS=',' read -r roll name m1 m2 m3
do
    # Skip empty lines
    [ -z "$roll" ] && continue

    fail_count=0

    # Check each subject
    if [ "$m1" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$m2" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$m3" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    # Exactly one subject failed
    if [ "$fail_count" -eq 1 ]; then
        echo "$roll, $name"
        fail_one_count=$((fail_one_count + 1))
    fi

    # Passed all subjects
    if [ "$fail_count" -eq 0 ]; then
        pass_all_count=$((pass_all_count + 1))
    fi

done < marks.txt

echo
echo "Students who passed in ALL subjects:"
echo "----------------------------------"

# Second loop to print pass-all students
while IFS=',' read -r roll name m1 m2 m3
do
    [ -z "$roll" ] && continue

    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll, $name"
    fi
done < marks.txt

echo
echo "Summary:"
echo "--------"
echo "Count of students failed in exactly one subject: $fail_one_count"
echo "Count of students passed in all subjects: $pass_all_count"

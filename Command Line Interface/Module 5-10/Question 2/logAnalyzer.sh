#!/bin/bash

# 1. Check command-line argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

LOGFILE="$1"

# 2. Validate file existence and readability
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' does not exist."
    exit 1
fi

if [ ! -r "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' is not readable."
    exit 1
fi

TOTAL=0
INFO=0
WARNING=0
ERROR=0
LAST_ERROR=""

# 3. Process the log file
while IFS= read -r line; do
    [ -z "$line" ] && continue

    TOTAL=$((TOTAL + 1))

    LEVEL=$(echo "$line" | awk '{print $3}')

    case "$LEVEL" in
        INFO)
            INFO=$((INFO + 1))
            ;;
        WARNING)
            WARNING=$((WARNING + 1))
            ;;
        ERROR)
            ERROR=$((ERROR + 1))
            LAST_ERROR="$line"
            ;;
    esac
done < "$LOGFILE"

# 4. Generate report
DATE=$(date +"%Y-%m-%d")
REPORT="logsummary_${DATE}.txt"

{
    echo "Log Summary Report"
    echo "=================="
    echo "Total log entries: $TOTAL"
    echo "INFO messages: $INFO"
    echo "WARNING messages: $WARNING"
    echo "ERROR messages: $ERROR"
    echo
    echo "Most recent ERROR message:"
    if [ -n "$LAST_ERROR" ]; then
        echo "$LAST_ERROR"
    else
        echo "None found"
    fi
} > "$REPORT"

# 5. Display output
cat "$REPORT"
echo
echo "Report saved to '$REPORT'"

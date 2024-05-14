#!/bin/bash

# Define the HTML file containing the table
html_file="sample.html"
html_table=$(<"$html_file")

# Initialize error count
error_count=0

# Iterate over each row of the HTML table
while IFS= read -r row; do
    # Check if the row contains an error status
    if [[ $row =~ \<td\>.*\</td\>\<td\>error\</td\> ]]; then
        # Increment error count
        ((error_count++))
    fi
done <<< "$html_table"

# Output error count
if (( error_count > 0 )); then
    echo "ERROR: $error_count service(s) with error status detected - Critical"
    exit 2  # Nagios critical status
else
    echo "OK: No service errors detected"
    exit 0  # Nagios OK status
fi


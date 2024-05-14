#!/bin/bash

# Define the HTML file containing the table
html_file="sample.html"
html_table=$(<"$html_file")

# Parse HTML table and check for error status
if [[ $html_table =~ \<td\>.*\</td\>\<td\>error\</td\> ]]; then
    # Trigger Nagios alert for error
    echo "ERROR: Service error detected - Critical"
    exit 2  # Nagios critical status
else
    echo "OK: No service errors detected"
    exit 0  # Nagios OK status
fi


#!/bin/bash

# Check if a service name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

# Define the service name to search for
service_name="$1"

# Define the HTML file containing the table
html_file="sample2.html"

# Use xmllint to extract the service status
service_status=$(xmllint --html --xpath "//tr[contains(td, '-INTERFACE STATUSES-')]/following-sibling::tr[td='$service_name']/td[2]/text()" "$html_file" 2>/dev/null | xargs)

# Check if the service status is empty (service not found) or '---------'
if [ -z "$service_status" ] || [ "$service_status" == "---------" ]; then
    echo "CRITICAL: Job count not completed or failed for service '$service_name'"
    exit 2  # Nagios critical status
else
    if [ "$service_status" == "error" ]; then
        echo "CRITICAL: Job count not completed or failed for service '$service_name'"
        exit 2  # Nagios critical status
    elif [ "$service_status" == "available" ]; then
        echo "OK: Job completed for service '$service_name'"
        exit 0  # Nagios OK status
    else
        echo "UNKNOWN: Service '$service_name' status is unknown"
        exit 3  # Nagios unknown status
    fi
fi


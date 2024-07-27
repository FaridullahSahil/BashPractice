#!/usr/bin/env bash

# URL to fetch data from
url="https://raw.githubusercontent.com/FaridullahSahil/BashPractice/main/names.csv"

# Fetch data from the URL and store it in a variable
response=$(curl -s "$url")

# Check if the response is empty
if [ -z "$response" ]; then
    echo "Error: No data retrieved from the URL."
    exit 1
fi

# Process the data line by line
echo "$response" | while IFS=',' read -r col1 col2 col3 || [ -n "$col1" ]; do
    # Skip the header row
    if [ "$col1" == "Customer" ]; then
        continue
    fi

    # Trim whitespace and remove any potential quotes from col3
    col3=$(echo "$col3" | tr -d '[:space:]"')

    # Check if col3 is a number and greater than or equal to 100000
    if [[ "$col3" =~ ^[0-9]+$ ]] && [ "$col3" -ge 100000 ]; then
        echo "$col1"
    fi
done

exit 0
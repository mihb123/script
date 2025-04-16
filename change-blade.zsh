#!/bin/zsh

# Script name: change-blade

# Check if file argument is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: change-blade <file-name>"
    exit 1
fi

file=$1
output_file="changed_$file"

# Check if file exists
if [[ ! -f $file ]]; then
    echo "File $file not found"
    exit 1
fi

# Create new file with changes
sed -E '
    # Skip lines already containing {{ asset
    /\{\{ asset/ b
    # Match lines with src or url and a path
    /src|url="[^"]*"/ {
        # Extract path after the first segment (up to first /)
        s@(src|url)="[^/]*/([^"]*)"@\1="{{ asset('\''frontend/jigyosho/\2'\'') }}"@g
    }
' $file > $output_file

echo "New file created: $output_file"

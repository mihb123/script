#!/bin/zsh

# Check if file argument is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: change-blade <file-name>"
    exit 1
fi

file=$1
backup_dir="origin"
backup_file="${backup_dir}/${file}"

# Check if file exists
if [[ ! -f $file ]]; then
    echo "File $file not found"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir" || {
    echo "Error: Failed to create backup directory $backup_dir"
    exit 1
}


# Create backup of original file
cp "$file" "$backup_file" || exit 1

# Process and overwrite original file
sed -E '
    # Skip lines already containing {{ asset
    /\{\{ asset/ b
    # Skip line contains http
    /http/ b
    /raw/ b
    # Match lines with src or url and a path
    /src|url|href="[^"]*"/ {
        # Extract path after the first segment (up to first /)
        s@(src|url|href)="[^/]*/([^"]*)"@\1="../jigyosho-raw/\2"@g
    }
	# s@require_once '\''\./([^'\'']*)'\''@include '\''\1'\''@g
	s@require_once\$docrt@//require_once\$docrt@g
	s@require_once '\''\./@include '\''@g
	s@require_once'\''\./@include '\''@g
' "$backup_file" > "$file"
echo "Backup saved to: $backup_file"
echo "$file is modified successfully"

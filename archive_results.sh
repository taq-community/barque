#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Example: $0 experiment1"
    exit 1
fi

# Set variables
arg1="$1"
timestampnow=$(date +%Y%m%d_%H%M%S)
archive_dir="archive-${arg1}-${timestampnow}"

# Define folders to archive
folders=(
    "05_trimmed"
    "06_merged"
    "07_split_amplicons"
    "08_chimeras"
    "09_vsearch"
    "10_read_dropout"
    "11_non_annotated"
    "12_results"
    "99_logfiles"
)

# Create archive directory
echo "Creating archive directory: ${archive_dir}"
mkdir -p "${archive_dir}"

# Copy folders to archive
echo "Copying folders to archive..."
for folder in "${folders[@]}"; do
    if [ -d "${folder}" ]; then
        echo "  Copying ${folder}..."
        cp -r "${folder}" "${archive_dir}/"
    else
        echo "  Warning: ${folder} not found, skipping..."
    fi
done

# Clean the original folders (remove contents but keep .gitignore files)
echo "Cleaning original folders..."
for folder in "${folders[@]}"; do
    if [ -d "${folder}" ]; then
        echo "  Cleaning ${folder}..."
        find "${folder}" -type f ! -name '.gitignore' -delete
    fi
done

# Compress the archive directory
echo "Compressing archive to ${archive_dir}.zip..."
zip -r "${archive_dir}.zip" "${archive_dir}"

# Remove the uncompressed archive directory
echo "Removing uncompressed archive directory..."
rm -rf "${archive_dir}"

echo "Archive created: ${archive_dir}.zip"
echo "Original folders cleaned!"
echo "Done!"

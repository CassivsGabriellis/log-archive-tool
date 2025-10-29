#!/usr/bin/env bash

# CLI tool to archive logs in a compressed file in a specified folder.

# Verifies if the directory was passed as argument
if [ -z "$1" ]; then
	echo "Use: $0 <log-directory>"
	exit 1
fi

LOG_DIR="$1"
ARCHIVE_DIR="$HOME/log_archives"

# Create the directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Generates timestamp for the archive name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Output file name
ARCHIVE_FILE="$ARCHIVE_DIR/logs_archive_${TIMESTAMP}.tar.gz"

# Compress the logs
sudo tar --exclude="archives" -czf "$ARCHIVE_FILE" -C "$LOG_DIR" .

# Create (or update) an operation registry file
echo "$(date +"%Y-%m-%d %H:%M:%S") - Created file: $ARCHIVE_FILE" >> "$ARCHIVE_DIR/archive_history.log"

echo "Archived logs in: $ARCHIVE_FILE"

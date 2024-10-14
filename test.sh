#!/bin/bash

# Define the source directory containing log files
LOG_DIR="./logs"

# Check if the source directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Log directory '$LOG_DIR' not found!"
  exit 1
fi

# Create a destination directory for organized logs
DEST_DIR="./organized_logs"
mkdir -p "$DEST_DIR"

# Loop through each log file in the source directory
for log_file in "$LOG_DIR"/*.log; do
  # Extract the date from the log file name (assumes format: YYYY-MM-DD.log)
  file_name=$(basename "$log_file")
  
  # Get the year and month from the file name (assumes format: YYYY-MM-DD.log)
  year=$(echo "$file_name" | cut -d'-' -f1)
  month=$(echo "$file_name" | cut -d'-' -f2)

  # Create a folder for each month in the destination directory
  month_folder="$DEST_DIR/$year-$month"
  mkdir -p "$month_folder"

  # Copy the log file into the appropriate month folder
  cp "$log_file" "$month_folder/"

  echo "Copied $file_name to $month_folder/"
done

echo "Log files have been organized by month."

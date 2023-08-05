#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sprint Progress
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 24h

# Optional parameters:
# @raycast.icon 🏃‍♂️
# @raycast.packageName Dashboard

# Documentation:
# @raycast.author Paul Tanchareon
# @raycast.authorURL https://github.com/paulvtan
# @raycast.description See the sprint progress on your desktop.

# Configuration
SPRINT_START="2023-01-02"  # Start date of the first sprint
SPRINT_LENGTH=14  # Length of each sprint in days

# Calculate Current Sprint Number and Remaining Days

current_date=$(date "+%Y-%m-%d")
start_date=$(date -j -f "%Y-%m-%d" "$SPRINT_START" "+%s")
current_sprint=$(( ( ( $(date -j -f "%Y-%m-%d" "$current_date" "+%s") - $start_date ) / 86400 ) / SPRINT_LENGTH + 1 ))
remaining_days=$(( ( ( $start_date + (SPRINT_LENGTH * 86400 * $current_sprint) ) - $(date -j -f "%Y-%m-%d" "$current_date" "+%s") ) / 86400 ))

# Display Current Sprint Number and Remaining Days
echo "Current Sprint: $current_sprint, Remaining Days: $remaining_days"

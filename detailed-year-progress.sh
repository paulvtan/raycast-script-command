#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Year Progress
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 24h

# Optional parameters:
# @raycast.icon 🗓️
# @raycast.packageName Dashboard

# Documentation:
# @raycast.author Paul Tanchareon
# @raycast.authorURL https://github.com/paulvtan
# @raycast.description See the year progress on your desktop.

# Inspired by
# Raycast script-commands by Thomas Paul Mann https://github.com/thomaspaulmann

# Configuration

OUTPUT_INCLUDES_BAR=true
BAR_LENGTH=20


# Main program

current_year=$(date +%Y)
current_day=$(date +%j)

if [ $((current_year % 400)) -eq 0 ]
then
  DAYS=366
elif [ $((current_year % 100)) -eq 0 ]
then
  DAYS=365
elif [ $((current_year % 4)) -eq 0 ]
then
  DAYS=366
else
  DAYS=365
fi

percentage=$((100 * 10#$current_day / $DAYS))

filled_element_count=$(($BAR_LENGTH * $percentage / 100))
blank_element_count=$(($BAR_LENGTH - $filled_element_count))
bar=""
for ((i = 0; i < $filled_element_count; i++)) {
  bar=${bar}"▓"
}
for ((i = 0; i < $blank_element_count; i++)) {
  bar=${bar}"░"
}

# Quarter Calculation

current_month=$(date +%m | sed 's/^0//')  # Remove leading zero
current_quarter=$((($current_month - 1) / 3 + 1))


case $current_quarter in
    1) quarter_end="March 31" ;;
    2) quarter_end="June 30" ;;
    3) quarter_end="September 30" ;;
    4) quarter_end="December 31" ;;
esac

last_day=$(date -d "$quarter_end" +%s 2>/dev/null || date -jf "%b %d" "$quarter_end" "+%s")
today=$(date +%s)
days_left=$((($last_day - $today) / 86400))
weeks_left=$((($days_left / 7) + 1))
days_left_year=$((($(date -jf "%Y-%m-%d" "$(date +%Y)-12-31" "+%s") - $today) / 86400))
current_week=$(date +%V)


# Display

YELLOW='\033[33m'
NC='\033[0m'

if [ "$OUTPUT_INCLUDES_BAR" = true ]
then
  echo -e ${bar}" "${percentage}"% "${YELLOW} "("${days_left_year}"d) | Q"${current_quarter} "("${days_left}"d) | W"${current_week}${NC}
else 
  echo ${percentage}"%"
fi



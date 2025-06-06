#!/usr/bin/env bash

# Check if the user has input a duration for the timer
if [ -z "$1" ]; then
	echo "Usage: $0 <minutes> [message]"
	exit 1
fi
# User settings
duration="$1"
message=${2:-"Timer done!"}
# Record the start time
start_time=$(date +%s)
# Run the timer
while true; do
	current_time=$(date +%s)
	elapsed_time=$((current_time - start_time))
	remaining_time=$((duration * 60 - elapsed_time))
	# Show the notification when the time is done
	if [ $remaining_time -le 0 ]; then
		notify-send -u critical "Time is up!" "$message"
		echo -e "\rTime is up!"
		exit 0
	fi
	# Print the time remaining
	if [ $remaining_time -ge 60 ]; then
		minutes=$((remaining_time / 60))
		seconds=$((remaining_time % 60))
		# Escape sequence to clear the line
		clr="\033[2K"
		if [ $seconds -eq 0 ]; then
			echo -ne "$clr\r${minutes}m "
		else
			echo -ne "$clr\r${minutes}m ${seconds}s "
		fi
	else
		echo -ne "$clr\r${remaining_time}s "
	fi
	# Tick the clock
	sleep 1
done

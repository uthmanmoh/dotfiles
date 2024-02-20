#!/bin/bash

# Check if inside an existing tmux session
if [ -n "$TMUX" ]; then
	echo "You are currently inside a tmux session. Please exit before running this script."
	exit 1
fi

# Define a list of directories you want to cd into for each window
directories=("~/.config/nvim" "~/dotfiles" "~/Documents/Obsidian Vault" "~/Documents/SchoolWork/Year4Sem1")

# Name of the tmux session
session_name="main"

# Check if the session already exists and attach to it if it does
tmux has-session -t $session_name 2>/dev/null
if [ $? -eq 0 ]; then
	echo "Session $session_name already exists. Attaching..."
	tmux attach-session -t $session_name
	exit 0
fi

# Since the session does not exist, create a new tmux session, detached (-d) and without creating a window (-n)
tmux new-session -d -s $session_name -n tmp

# Iterate over the directories
for i in "${!directories[@]}"; do
	dir=${directories[$i]}

	# For the first directory, rename the initial window rather than creating a new one
	if [ $i -eq 0 ]; then
		tmux rename-window -t $session_name:1 "$(basename -- "$dir")"
		tmux send-keys -t $session_name:1 "cd $dir && clear" C-m
	else
		# Create a new window for each directory
		tmux new-window -t $session_name -n "$(basename -- "$dir")"
		# Send command to cd into the directory and press Enter
		tmux send-keys -t $session_name:$((i + 1)) "cd $dir && clear" C-m
	fi
done

# Attach to the new session
tmux attach-session -t $session_name

#!/bin/bash

# Read current path from stdin
input=$(cat)

# Attempt to get the root directory of the Git repo (if exists)
git_root=$(git -C "$input" rev-parse --show-toplevel 2>/dev/null)

if [ -n "$git_root" ]; then
	# If inside a Git repo, extract and display the name of the root folder
	echo "$(basename "$git_root")"
else
	# If not in a Git repo, proceed with the original path shortening logic

	# Replace $HOME with ~
	modifiedPath=${input/#$HOME/\~}

	# Process the path with awk
	echo "$modifiedPath" | awk -F '/' '{if(NF > 3){print "/…/"$(NF-1)"/"$(NF)}else{print}}'
fi

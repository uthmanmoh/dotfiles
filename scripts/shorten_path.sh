#!/bin/bash

# Read from stdin
input=$(cat)

# Replace $HOME with ~
modifiedPath=${input/#$HOME/\~}

# Process the path with awk
echo "$modifiedPath" | awk -F '/' '{if(NF > 4){print "/…/"$(NF-2)"/"$(NF-1)"/"$(NF)}else{print}}'

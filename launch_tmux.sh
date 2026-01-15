#!/bin/bash

# Session Name
session="Development"

# Start new session
tmux new-session -d -s $session

# Rename first window
tmux rename-window -t 0 'build'

# Create other windows
tmux new-window -t $session:1 -n 'src'
tmux new-window -t $session:2 -n 'openj9'
tmux new-window -t $session:3 -n 'omr'
tmux new-window -t $session:4

# Go to the right paths
tmux send-keys -t 'src' 'cdj9' C-m 'cd src' C-m 'nvim' C-m
tmux send-keys -t 'openj9' 'cdj9' C-m 'cd j9' C-m
tmux send-keys -t 'omr' 'cdj9' C-m 'cd omr' C-m
tmux send-keys -t 'cdj9' C-m

# Attach to the session
tmux attach-session -t $session:1

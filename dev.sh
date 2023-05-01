#! /bin/bash
# This script is used to start the development environment


tm() {
  # If no argument is given, list all the workspaces
  selected=$1
  if [ -z $1 ]; then
    selected=`ls ~/Workspaces/ | fzf` 
  fi
  selected=`echo $selected | sed 's/\./_/g'`
  echo $selected
  if [ -z "$TMUX" ]; then
    tmux new-session -As "$selected"
  else
    if ! tmux has-session -t $selected 2>/dev/null; then
      TMUX= tmux new-session -ds "$selected"
    fi
    echo "switching to $selected session"
    tmux switch-client -t "$selected"
  fi
}

tm $1

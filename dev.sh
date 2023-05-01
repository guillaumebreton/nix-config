#!/bin/zsh
# This script is used to start the development environment


tm() {
  # If no argument is given, list all the workspaces
  selected=$1
  if [ -z $1 ]; then
    selected=`ls ~/Workspaces/ | fzf` 
  fi

  # ctrl-c pressed
  if [ -z $selected ]; then
    exit 0
  fi
  
  WORKING_DIRECTORY=$(cdpath=(. ~/Workspaces) cd $selected > /dev/null 2>&1 && pwd)
  echo "working directory: $WORKING_DIRECTORY"

  # Switch session
  session_name=`echo $selected | sed 's/\./_/g'`
  if [ -z "$TMUX" ]; then
    tmux new-session -As $session_name -c $WORKING_DIRECTORY
  else
    if ! tmux has-session -t $session_name 2>/dev/null; then
      TMUX= tmux new-session -ds $session_name -c $WORKING_DIRECTORY
    fi
    echo "switching to $session_name session"
    tmux switch-client -t $session_name
  fi
}

tm $1

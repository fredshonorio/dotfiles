#!/usr/bin/env bash
# Claude Code status line - inspired by Powerlevel10k Pure style

input=$(cat)

# Extract fields from JSON input
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# user@host (grey, only show if not empty)
user=$(whoami)
host=$(hostname -s)

# Shorten home directory to ~
if [ -n "$cwd" ]; then
  home_dir="$HOME"
  short_dir="${cwd/#$home_dir/~}"
else
  short_dir="$(pwd | sed "s|^$HOME|~|")"
fi

# Git branch and dirty status (skip locks to be safe)
git_info=""
if git -c core.fsmonitor=false rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -c core.fsmonitor=false symbolic-ref --short HEAD 2>/dev/null || git -c core.fsmonitor=false rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    if ! git -c core.fsmonitor=false diff --quiet 2>/dev/null || ! git -c core.fsmonitor=false diff --cached --quiet 2>/dev/null; then
      dirty="*"
    fi
    git_info=" $branch$dirty"
  fi
fi

# Context usage indicator
ctx_info=""
if [ -n "$used_pct" ]; then
  ctx_int=$(printf '%.0f' "$used_pct")
  ctx_info=" ctx:${ctx_int}%"
fi

# Model info (short form)
model_info=""
if [ -n "$model" ]; then
  model_info=" | $model"
fi

# Build the status line using ANSI colors (dimmed-friendly)
# grey=\e[2m, blue=\e[34m, cyan=\e[36m, magenta=\e[35m, reset=\e[0m
printf "\e[2m%s@%s\e[0m  \e[34m%s\e[0m\e[36m%s\e[0m\e[2m%s\e[0m\e[35m%s\e[0m" \
  "$user" "$host" \
  "$short_dir" \
  "$git_info" \
  "$ctx_info" \
  "$model_info"

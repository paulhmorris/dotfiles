#!/bin/bash
# Claude Code status line
# Shows: model, effort level, cwd, git branch, context window usage

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')

dir_display="${cwd/#$HOME/\~}"
dir_display="$(basename "$dir_display")"

branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

used=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
remaining=$((total - used))

fmt_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000) printf "%.1fk", n / 1000;
    else printf "%d", n;
  }'
}

used_fmt=$(fmt_tokens "$used")
total_fmt=$(fmt_tokens "$total")

DIM='\033[2m'
RESET='\033[0m'
CYAN='\033[2;36m'
YELLOW='\033[2;33m'
GREEN='\033[2;32m'
MAGENTA='\033[2;35m'

# Model + effort segment
model_segment="${CYAN}${model}${RESET}"
if [ -n "$effort" ]; then
  model_segment="${model_segment}${DIM} (${effort})${RESET}"
fi

# Directory segment
dir_segment="${YELLOW}${dir_display}${RESET}"

# Git branch segment
if [ -n "$branch" ]; then
  git_segment="${GREEN}${branch}${RESET}"
fi

# Context window segment
if [ "$total" -gt 0 ]; then
  ctx_segment="${MAGENTA}${used_fmt}/${total_fmt} tokens${RESET}"
fi

sep="${DIM} · ${RESET}"

out="$model_segment"
out="${out}${sep}${dir_segment}"
if [ -n "$git_segment" ]; then
  out="${out}${sep}${git_segment}"
fi
if [ -n "$ctx_segment" ]; then
  out="${out}${sep}${ctx_segment}"
fi

printf "%b" "$out"

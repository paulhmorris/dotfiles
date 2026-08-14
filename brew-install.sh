#!/usr/bin/env bash
# Install every package listed in Brewfile (macOS only). Requires Homebrew:
# https://brew.sh
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command -v brew >/dev/null 2>&1 || { echo "brew not found, install it first" >&2; exit 1; }

brew bundle install --file="$DOTFILES_DIR/Brewfile"

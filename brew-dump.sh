#!/usr/bin/env bash
# Refresh Brewfile from what's currently installed. Run after installing/removing packages.
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force
echo "Brewfile updated. Review with 'git diff' and commit."

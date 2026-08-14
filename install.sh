#!/usr/bin/env bash
# Symlink every path in manifest.txt from files/ into $HOME.
# Existing real files/dirs are moved to a timestamped backup first.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$DOTFILES_DIR/manifest.txt"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

while IFS= read -r rel; do
  rel="${rel%%#*}"                # strip inline comments
  rel="$(echo "$rel" | xargs)"    # trim whitespace
  [ -z "$rel" ] && continue

  src="$DOTFILES_DIR/files/$rel"
  dst="$HOME/$rel"

  if [ ! -e "$src" ]; then
    echo "skip $rel (missing in files/)" >&2
    continue
  fi

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ]; then
    [ "$(readlink "$dst")" = "$src" ] && { echo "ok   $rel"; continue; }
    rm "$dst"
  elif [ -e "$dst" ]; then
    mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
    mv "$dst" "$BACKUP_DIR/$rel"
    echo "backed up $rel -> $BACKUP_DIR/$rel"
  fi

  ln -s "$src" "$dst"
  echo "link $rel"
done < "$MANIFEST"

[ -d "$BACKUP_DIR" ] && echo "backups saved to $BACKUP_DIR"

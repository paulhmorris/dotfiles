#!/usr/bin/env bash
# Move a real file/dir under $HOME into this repo and symlink it back.
# Usage: ./add.sh ~/.some/config
set -euo pipefail

[ $# -eq 1 ] || { echo "usage: $0 <path under \$HOME>" >&2; exit 1; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$DOTFILES_DIR/manifest.txt"

src_abs="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
case "$src_abs" in
  "$HOME"/*) rel="${src_abs#"$HOME"/}" ;;
  *) echo "error: $1 is not under \$HOME" >&2; exit 1 ;;
esac

dst="$DOTFILES_DIR/files/$rel"
[ -e "$src_abs" ] || { echo "error: $src_abs does not exist" >&2; exit 1; }
[ -L "$src_abs" ] && { echo "error: $src_abs is already a symlink" >&2; exit 1; }

mkdir -p "$(dirname "$dst")"
mv "$src_abs" "$dst"
ln -s "$dst" "$src_abs"
grep -qxF "$rel" "$MANIFEST" || echo "$rel" >> "$MANIFEST"

echo "moved $src_abs -> $dst, symlinked back, added to manifest"

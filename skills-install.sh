#!/usr/bin/env bash
# Reinstall global skills (npx skills) from .agents/.skill-lock.json.
# `skills experimental_install` only restores project-level skills-lock.json,
# not this global lockfile, so we replay it ourselves: group tracked skills
# by source repo and re-add each group.
set -euo pipefail

LOCKFILE="$HOME/.agents/.skill-lock.json"
command -v jq >/dev/null 2>&1 || { echo "jq required" >&2; exit 1; }
[ -f "$LOCKFILE" ] || { echo "no lockfile at $LOCKFILE" >&2; exit 1; }

jq -r '.skills | to_entries | group_by(.value.source)[] |
  "\(.[0].value.source)\t\(map(.key) | join(" "))"' "$LOCKFILE" |
while IFS=$'\t' read -r source skills; do
  echo "== $source: $skills"
  npx --yes skills@latest add "$source" -g -y -s $skills
done

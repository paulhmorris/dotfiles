# dotfiles

Config files scattered across the machine, backed up here and symlinked
back into place. Works on macOS and Linux.

## Layout

- `files/` — actual file contents, stored at their path relative to `$HOME`
  (e.g. `files/.zshrc` -> `~/.zshrc`)
- `manifest.txt` — list of paths (relative to `$HOME`) to link. Comment out
  a line with `#` to skip it on a given machine.
- `install.sh` — symlinks everything in the manifest into `$HOME`, backing
  up any existing real file first.
- `add.sh` — moves an existing file/dir under `$HOME` into `files/`,
  symlinks it back, and adds it to the manifest.
- `Brewfile` — macOS Homebrew taps/formulae/casks, via `brew bundle`.
- `brew-dump.sh` — refreshes `Brewfile` from what's currently installed.
- `brew-install.sh` — installs everything in `Brewfile` (macOS only).

## Usage

Clone and install:

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

Existing files at the target paths are moved to `~/.dotfiles-backup/<timestamp>/`
before the symlink is created — nothing is deleted.

On macOS, restore all Homebrew packages:

```sh
./brew-install.sh
```

After installing/removing brew packages, refresh the list:

```sh
./brew-dump.sh
git add Brewfile && git commit -m "update Brewfile"
```

Add a new file to track:

```sh
./add.sh ~/.gitconfig
git add -A && git commit -m "add .gitconfig"
```

## Notes

- `.zshrc` is zsh-specific and won't work under Linux's default bash.
  Comment it out of `manifest.txt` on machines without zsh, or install zsh.
- `.claude/skills` is only the manually-authored skills, not
  plugin-installed ones (those live under `.claude/plugins` and aren't
  tracked here).

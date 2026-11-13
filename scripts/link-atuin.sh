#!/usr/bin/env bash
# Symlink dotfiles atuin to ~/.config so atuin uses the config + theme from this repo.
set -e
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
TARGET="$HOME/.config/atuin"
if [[ -L "$TARGET" ]]; then
  echo "Already a symlink: $TARGET -> $(readlink "$TARGET")"
  exit 0
fi
if [[ -e "$TARGET" ]]; then
  echo "Backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
fi
ln -sfn "$DOTFILES/atuin" "$TARGET"
echo "Linked: $TARGET -> $DOTFILES/atuin"

#!/usr/bin/env bash
# Symlink dotfiles gtk-4.0 to ~/.config so GTK apps (pavucontrol, iwgtk, etc.) use this theme.
set -e
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
TARGET="$HOME/.config/gtk-4.0"
if [[ -L "$TARGET" ]]; then
  echo "Already a symlink: $TARGET -> $(readlink "$TARGET")"
  exit 0
fi
if [[ -e "$TARGET" ]]; then
  echo "Backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
fi
ln -sfn "$DOTFILES/gtk-4.0" "$TARGET"
echo "Linked: $TARGET -> $DOTFILES/gtk-4.0"

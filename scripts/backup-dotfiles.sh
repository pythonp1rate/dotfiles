#!/usr/bin/env bash
# Full gzip tar backup of dotfiles. Safe to run anytime.
# Usage: ./scripts/backup-dotfiles.sh
# Creates: ../dotfiles-backups/dotfiles-YYYYMMDD-HHMM.tar.gz (or set BACKUP_DIR)

set -e
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="${BACKUP_DIR:-$(dirname "$REPO_ROOT")/dotfiles-backups}"
DATE="$(date +%Y%m%d-%H%M)"
ARCHIVE="${BACKUP_DIR}/dotfiles-${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"
cd "$(dirname "$REPO_ROOT")"

# gzip tar of the whole dotfiles folder (.git included for history)
tar -czvf "$ARCHIVE" --exclude='*.tar.gz' "$(basename "$REPO_ROOT")"

echo ""
echo "Backup written: $ARCHIVE"
ls -la "$ARCHIVE"

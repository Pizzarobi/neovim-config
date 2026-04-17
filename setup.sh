#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

echo "==> Installing dependencies..."

if command -v apt-get &>/dev/null; then
  sudo apt-get update -q
  sudo apt-get install -y neovim ripgrep gcc git
elif command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm neovim ripgrep gcc git
elif command -v dnf &>/dev/null; then
  sudo dnf install -y neovim ripgrep gcc git
else
  echo "Unknown package manager. Install neovim, ripgrep, and gcc manually."
  exit 1
fi

echo "==> Copying config..."
mkdir -p "$NVIM_CONFIG"
cp "$SCRIPT_DIR/init.lua" "$NVIM_CONFIG/init.lua"

echo "==> Bootstrapping plugins (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa

echo "==> Done. Run 'nvim' to start."

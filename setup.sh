#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

echo "==> Installing dependencies..."

if command -v apt-get &>/dev/null; then
  sudo apt-get update -q
  sudo apt-get install -y neovim ripgrep gcc git curl
elif command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm neovim ripgrep gcc git curl
elif command -v dnf &>/dev/null; then
  sudo dnf install -y neovim ripgrep gcc git curl
else
  echo "Unknown package manager. Install neovim, ripgrep, and gcc manually."
  exit 1
fi

# nvim-treesitter (main branch) needs tree-sitter-cli >= 0.26.1; distro packages are too old
if ! command -v tree-sitter &>/dev/null; then
  echo "==> Installing tree-sitter-cli to ~/.local/bin..."
  case "$(uname -m)" in
    x86_64) TS_ARCH=x64 ;;
    aarch64) TS_ARCH=arm64 ;;
    *) echo "Unsupported arch for tree-sitter-cli; install it manually."; exit 1 ;;
  esac
  mkdir -p "$HOME/.local/bin"
  curl -sL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$TS_ARCH.gz" \
    | gunzip > "$HOME/.local/bin/tree-sitter"
  chmod +x "$HOME/.local/bin/tree-sitter"
  export PATH="$HOME/.local/bin:$PATH"
fi

if ! nvim --headless "+lua if vim.fn.has('nvim-0.12') == 0 then vim.cmd('cq') end" +qa 2>/dev/null; then
  echo "WARNING: Neovim 0.12+ required (nvim-treesitter main branch). Your distro package is too old."
  echo "         Install a newer one, e.g. from https://github.com/neovim/neovim/releases"
fi

echo "==> Copying config..."
mkdir -p "$NVIM_CONFIG"
if [ "$SCRIPT_DIR" != "$(cd "$NVIM_CONFIG" && pwd)" ]; then
  cp "$SCRIPT_DIR/init.lua" "$NVIM_CONFIG/init.lua"
else
  echo "  -> Config already in place, skipping copy."
fi

echo "==> Bootstrapping plugins (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa

echo "==> Done. Run 'nvim' to start."

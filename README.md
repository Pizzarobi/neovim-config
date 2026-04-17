# Neovim Config

Cross-platform Neovim setup for Linux and Windows.

## Quick Start

**Linux**
```bash
git clone <your-repo-url> ~/.config/nvim
bash ~/.config/nvim/setup.sh
```

**Windows** (PowerShell as admin)
```powershell
git clone <your-repo-url> "$env:LOCALAPPDATA\nvim"
cd "$env:LOCALAPPDATA\nvim"
.\setup.ps1
```

The setup scripts install all dependencies, copy the config, and sync plugins automatically.

> **Windows:** After setup, install a [Nerd Font](https://www.nerdfonts.com) and set it in your terminal for icons to render correctly.

---

## Plugins

| Plugin | What it does |
|---|---|
| **catppuccin** | Colorscheme (mocha variant) |
| **nvim-treesitter** | Accurate syntax highlighting via code parsing |
| **nvim-tree** | File explorer sidebar (`<Space>e` to toggle) |
| **bufferline** | Tab bar for open buffers (`H`/`L` to cycle, `<Space>x` to close) |
| **lualine** | Status line at the bottom |
| **nvim-cmp** | Autocompletion (Tab to select, Enter to confirm) |
| **LuaSnip** | Snippet engine (used by nvim-cmp) |
| **telescope** | Fuzzy finder — files (`<Space>ff`), grep (`<Space>fg`), buffers (`<Space>fb`) |
| **nvim-autopairs** | Auto-closes brackets, quotes, etc. |
| **Comment.nvim** | Toggle comments with `gcc` (line) or `gc` (visual) |

## External Dependencies

| Tool | Purpose | Linux | Windows |
|---|---|---|---|
| `ripgrep` | Telescope live grep | installed by setup.sh | installed by setup.ps1 |
| `gcc` / `zig` | Compile Treesitter parsers | gcc via apt/pacman/dnf | zig via winget |
| `git` | Plugin manager needs it | usually pre-installed | installed by setup.ps1 |

---

## Keybindings

| Key | Action |
|---|---|
| `<Space>e` | Toggle file tree |
| `<Space>o` | Focus file tree |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep (search file contents) |
| `<Space>fb` | Find open buffers |
| `<Space>x` | Close current buffer |
| `H` / `L` | Cycle buffers left/right |
| `gcc` | Toggle comment on line |
| `gc` | Toggle comment on selection |

#Requires -Version 5.1
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$nvimConfig = "$env:LOCALAPPDATA\nvim"

Write-Host "==> Installing dependencies via winget..."

$packages = @(
  @{ id = "Neovim.Neovim";              name = "Neovim"   },
  @{ id = "BurntSushi.ripgrep.MSVC";    name = "ripgrep"  },
  @{ id = "zig.zig";                    name = "Zig"      },
  @{ id = "Git.Git";                    name = "Git"      }
)

foreach ($pkg in $packages) {
  Write-Host "  -> $($pkg.name)"
  winget install --id $pkg.id --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "==> Refreshing PATH..."
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH", "User")

Write-Host "==> Copying config..."
New-Item -ItemType Directory -Force -Path $nvimConfig | Out-Null
if ((Resolve-Path "$scriptDir\init.lua").Path -ne (Resolve-Path "$nvimConfig\init.lua" -ErrorAction SilentlyContinue).Path) {
  Copy-Item "$scriptDir\init.lua" "$nvimConfig\init.lua" -Force
} else {
  Write-Host "  -> Config already in place, skipping copy."
}

Write-Host "==> Bootstrapping plugins (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa

Write-Host "==> Done. Run 'nvim' to start."

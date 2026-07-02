#!/usr/bin/env bash
# ======================================================
# Oh My Zsh Custom Setup — Installer
# ======================================================
# This script installs Oh My Zsh (if missing) and sets up
# the theme and plugins used in this dotfiles project.
#
# Usage:
#   bash setup.sh
# ======================================================

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "========================================="
echo " Oh My Zsh Custom Setup"
echo "========================================="

# ------------------------------------------------------------------
# 1. Meslo Nerd Font (required by Powerlevel10k)
# ------------------------------------------------------------------
FONT_NAME="MesloLGS NF"
FONT_DIR=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  FONT_DIR="$HOME/Library/Fonts"
else
  FONT_DIR="$HOME/.local/share/fonts"
fi

if fc-list ":family=${FONT_NAME}" 2>/dev/null | grep -qi "${FONT_NAME}"; then
  echo ">>> ${FONT_NAME} already installed — skipping."
else
  echo ">>> Installing ${FONT_NAME}..."
  mkdir -p "$FONT_DIR"
  FONT_BASE="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF"
  for variant in "Regular" "Bold" "Italic" "Bold Italic"; do
    url="${FONT_BASE}%20${variant}.ttf"
    # URL-decode %20 back to space for the filename
    filename="MesloLGS NF ${variant}.ttf"
    if [ ! -f "$FONT_DIR/$filename" ]; then
      echo "  Downloading $filename..."
      curl -fsSL -o "$FONT_DIR/$filename" "$url"
    fi
  done
  # Rebuild font cache on Linux
  if command -v fc-cache &>/dev/null; then
    fc-cache -f "$FONT_DIR"
  fi
  echo ">>> ${FONT_NAME} installed."
  echo ">>> IMPORTANT: Set ${FONT_NAME} as your terminal font, then restart your terminal."
fi

# ------------------------------------------------------------------
# 2. Oh My Zsh
# ------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo ">>> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo ">>> Oh My Zsh already installed — skipping."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ------------------------------------------------------------------
# 3. Powerlevel10k theme
# ------------------------------------------------------------------
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo ">>> Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo ">>> Powerlevel10k already installed — skipping."
fi

# ------------------------------------------------------------------
# 4. Plugins
# ------------------------------------------------------------------
install_plugin() {
  local name="$1"
  local url="$2"
  if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
    echo ">>> Installing plugin: $name..."
    git clone --depth=1 "$url" "$ZSH_CUSTOM/plugins/$name"
  else
    echo ">>> Plugin $name already installed — skipping."
  fi
}

install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
install_plugin "zsh-autosuggestions"     "https://github.com/zsh-users/zsh-autosuggestions.git"

# ------------------------------------------------------------------
# 5. Link config files
# ------------------------------------------------------------------
echo ">>> Linking config files..."
ln -sf "$DOTFILES/.zshrc"  "$HOME/.zshrc"
ln -sf "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"

# ------------------------------------------------------------------
# 6. Done
# ------------------------------------------------------------------
echo ""
echo "========================================="
echo " Setup complete!"
echo "========================================="
echo "Restart your shell or run:  exec zsh"

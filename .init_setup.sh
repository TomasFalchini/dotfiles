#!/bin/bash
set -euo pipefail

echo "🚀  Setting up @tomasfalchini dotfiles."

if xcode-select -p &> /dev/null; then
  echo "✅  Xcode command line tools are already installed."
else
  echo "🔧  Installing Xcode command line tools..."
  xcode-select --install &> /dev/null
  
  while ! xcode-select -p &> /dev/null; do
    sleep 5
  done
  echo "✅  Xcode command line tools installed successfully."
fi

if command -v brew >/dev/null 2>&1; then
  echo "✅  Homebrew is already installed."
else
  echo "🍺  Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅  Homebrew installed successfully."
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦  Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "✅  Oh My Zsh installed"
fi

if command -v chezmoi >/dev/null 2>&1; then
  echo "✅  Chezmoi is already installed."
else
  echo "⚪️  Installing Chezmoi"
  brew install chezmoi
fi

if [ -d "/Applications/Cursor.app" ]; then
  echo "✅  Cursor is already installed."
else
  echo "📝  Installing Cursor..."
  brew install --cask cursor
  echo "✅  Cursor installed successfully."
fi

if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
  echo "ℹ️  Chezmoi already initialized, pulling latest changes..."
  chezmoi update
  echo "✅  Chezmoi updated"
else
  chezmoi init tomasfalchini
  chezmoi apply
  echo "✅  Chezmoi initialized"
fi


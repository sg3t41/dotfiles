#!/bin/bash

# Neovim config backup and removal
if [ -d "$HOME/.config/nvim" ]; then
  echo "Backing up Neovim config to ~/.config/nvim_backup..."
  mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup"
else
  echo "No Neovim config found at ~/.config/nvim."
fi

# Neovim plugins and data cleanup
if [ -d "$HOME/.local/share/nvim" ]; then
  echo "Removing Neovim plugins and data from ~/.local/share/nvim..."
  rm -rf "$HOME/.local/share/nvim"
else
  echo "No Neovim data found at ~/.local/share/nvim."
fi

# Neovim state files (shada, undo history, etc.)
if [ -d "$HOME/.local/state/nvim" ]; then
  echo "Removing Neovim state files from ~/.local/state/nvim..."
  rm -rf "$HOME/.local/state/nvim"
else
  echo "No Neovim state files found at ~/.local/state/nvim."
fi

# Neovim cache cleanup
if [ -d "$HOME/.cache/nvim" ]; then
  echo "Removing Neovim cache from ~/.cache/nvim..."
  rm -rf "$HOME/.cache/nvim"
else
  echo "No Neovim cache found at ~/.cache/nvim."
fi

echo "Neovim cleanup completed. You can now restart Neovim with default settings."


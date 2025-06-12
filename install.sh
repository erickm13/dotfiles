#!/bin/bash

DOTFILES="$HOME/dotfiles"

# Función para crear symlinks seguros con backup
create_symlink() {
  local target=$1
  local link=$2

  if [ -L "$link" ]; then
    echo "🔁 Eliminando symlink anterior: $link"
    rm "$link"
  elif [ -e "$link" ]; then
    echo "📦 Haciendo backup de $link → ${link}.backup"
    mv "$link" "${link}.backup"
  fi

  echo "🔗 Creando symlink: $link → $target"
  ln -sf "$target" "$link"
}

echo "🚀 Instalando dotfiles..."

# Neovim
create_symlink "$DOTFILES/nvim" "$HOME/.config/nvim"

# Zsh
create_symlink "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# Wezterm
create_symlink "$DOTFILES/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# Tmux
create_symlink "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# fzf-git.sh (descarga o actualiza)
FZF_GIT_DIR="$DOTFILES/fzf-git.sh"
if [ ! -d "$FZF_GIT_DIR" ]; then
  echo "📦 Clonando fzf-git.sh..."
  git clone https://github.com/junegunn/fzf-git.sh.git "$FZF_GIT_DIR"
else
  echo "🔄 Actualizando fzf-git.sh..."
  git -C "$FZF_GIT_DIR" pull --quiet
fi

# Ejecutar script post-check (si existe)
if [ -f "$DOTFILES/post-check.sh" ]; then
  echo "✅ Ejecutando verificación de enlaces..."
  bash "$DOTFILES/post-check.sh"
fi

echo "🎉 Instalación completa."

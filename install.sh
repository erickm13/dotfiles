#!/bin/bash

echo "🔗 Creando enlaces simbólicos y configuraciones..."

# Detectar usuario de Windows desde cmd.exe
WINDOWS_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
WINDOWS_HOME="/mnt/c/Users/$WINDOWS_USER"
REPO_PATH="$(pwd)"

# Neovim
mkdir -p ~/.config/nvim
ln -sf "$REPO_PATH/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$REPO_PATH/nvim/lua" ~/.config/nvim/lua

# Zsh
ln -sf "$REPO_PATH/zsh/.zshrc" ~/.zshrc

# WezTerm (copiar en vez de symlink)
cp -f "$REPO_PATH/wezterm/.wezterm.lua" "$WINDOWS_HOME/.wezterm.lua"

echo ""
echo "✅ Instalación completa. Verificando enlaces..."

# Función para verificar symlinks
check_symlink() {
  local target=$1
  local expected=$2

  if [ -L "$target" ]; then
    actual=$(readlink -f "$target")
    if [ "$actual" == "$expected" ]; then
      echo "✅ $target → OK"
    else
      echo "⚠️ $target → Apunta a $actual, debería ser $expected"
    fi
  else
    echo "❌ $target → No es un enlace simbólico"
  fi
}

# Función para verificar archivos copiados
check_file_copy() {
  local path=$1
  if [ -f "$path" ]; then
    echo "✅ $path → Archivo presente"
  else
    echo "❌ $path → No se encontró el archivo"
  fi
}

# Ejecutar verificaciones
check_symlink ~/.zshrc "$REPO_PATH/zsh/.zshrc"
check_symlink ~/.config/nvim/init.lua "$REPO_PATH/nvim/init.lua"
check_file_copy "$WINDOWS_HOME/.wezterm.lua"

echo "🧪 Verificación finalizada."

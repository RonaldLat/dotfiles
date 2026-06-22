#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Linking dotfiles..."

# Compatibility symlink — .zshrc references ~/dotfiles/ohmyposh_themes/
ln -sfT "$DOTFILES" "$HOME/dotfiles"

ln -sf "$DOTFILES/.zshrc"   "$HOME/.zshrc"
ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config"
for dir in nvim yazi; do
  src="$DOTFILES/.config/$dir"
  if [ -d "$src" ]; then
    ln -sfT "$src" "$HOME/.config/$dir"
    echo "  linked .config/$dir"
  fi
done

echo "==> Installing tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true

echo "==> Installing Zap zsh plugin manager..."
ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
if [ ! -f "$ZAP_DIR/zap.zsh" ]; then
  mkdir -p "$ZAP_DIR"
  git clone --depth 1 https://github.com/zap-zsh/zap.git "$ZAP_DIR"
fi

echo "==> Setting zsh as default shell..."
if command -v zsh &>/dev/null && [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo chsh -s /usr/bin/zsh "$(whoami)" 2>/dev/null || true
fi

echo "==> Done"

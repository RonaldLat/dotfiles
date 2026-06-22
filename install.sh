#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

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

echo "==> Installing Nerd Fonts..."
if [ -f "$DOTFILES/scripts/nf_installer.sh" ]; then
  bash "$DOTFILES/scripts/nf_installer.sh"
fi

echo "==> Setting zsh as default shell..."
if command -v zsh &>/dev/null && [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo chsh -s /usr/bin/zsh "$(whoami)" 2>/dev/null || true
fi

echo "==> Done"

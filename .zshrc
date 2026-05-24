# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/ronald/.zsh/completions:"* ]]; then export FPATH="/home/ronald/.zsh/completions:$FPATH"; fi
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

alias pn="pnpm"
# Load and initialise completion system
autoload -Uz compinit
compinit

alias cat="bat"
alias ranger=". ranger"
#alias ranger="ranger"
alias pacs="sudo pacman -S "
alias pn="pnpm"
alias exd="xrandr --output eDP-1 --mode 1920x1080 --rate 60 --primary --output HDMI-2 --mode 3840x2160 --rate 30 --right-of eDP-1"
alias lg="lazygit"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down "
alias dcr="docker compose restart "
alias dcl="docker compose logs "
alias vv="nvim"
alias rec='wf-recorder -g "$(slurp)" -f ~/Videos/Recordings/rec_$(date +%Y%m%d_%H%M%S).mp4'
# SSHFS Mount Aliases
alias mountbook="sshfs ronald@100.81.96.50:/home/ronald/1TB/Library/Audiobooks ~/Remote-Library/audiobooks -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3"
alias unmountbook="fusermount -u ~/Remote-Library/audiobooks"
# SSHFS Master 1TB HDD Mount
alias mount1tb="sshfs ronald@100.81.96.50:/home/ronald/1TB ~/Remote-Library/1TB-HDD -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3"
alias unmount1tb="fusermount -u ~/Remote-Library/1TB-HDD"

# RSYNC SSHFS File Operations (Laptop <-> HDD)
# 1. Safe Move: Copies to HDD, verifies, then deletes from laptop
alias hdd-mv="rsync -rhP --remove-source-files"

# 2. Safe Copy: Copies to HDD, keeps local copy on laptop
alias hdd-cp="rsync -rhP"

# 3. Two-Way Sync: Keeps laptop folder and HDD folder perfectly identical
# (Warning: --delete removes files from destination if they were deleted on source)
alias hdd-sync="rsync -rhP --delete"

# 4. Pull: Easily grab a massive folder/file from HDD to Laptop Downloads
alias hdd-pull="rsync -rhP"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/ronald/.bun/_bun" ] && source "/home/ronald/.bun/_bun"

#PS1='%~: '
#exec ~/.fehbg


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export ZK_NOTEBOOK_DIR="$HOME/zettelkasten/"

export EDITOR="nvim"
# ohmyposh
export PATH=$PATH:/home/ronald/bin

# bitwarden-cli
export BW_SESSION="Rn728lD9CzFcQunUYfTWGFO+2Kq6YpR6dN9JVQ9pV5aMVSHG3EUSlqCz1b0wO5wYPlec+off+7UPYMFsI1MI0g=="

#proxies
#export http_proxy="http://192.168.12.194:44355"
#export https_proxy="http://192.168.12.194:44355"
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config ~/dotfiles/ohmyposh_themes/amro.omp.json)"

# change working directory when exiting yazi
# Then use y instead of yazi to start, and press q to quit, you'll see the CWD changed. Sometimes, you don't want to change, press Q to quit.

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/ron/.dart-cli-completion/zsh-config.zsh ]] && . /home/ron/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


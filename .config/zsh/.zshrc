# =========================================================
# ~/.config/zsh/.zshrc
# WSL-friendly version
# =========================================================

# ---------------------------------------------------------
# 基础环境
# ---------------------------------------------------------

export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/oh-my-zsh"

export HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

export LESSHISTFILE="$XDG_CACHE_HOME/less/.less_history"
export TMUX_TMPDIR="$XDG_CACHE_HOME/tmux"
export NUGET_PACKAGES="$XDG_CACHE_HOME/nuget"

mkdir -p "$ZSH_CACHE_DIR" "$TMUX_TMPDIR" "$(dirname "$HISTFILE")" "$(dirname "$LESSHISTFILE")"

# Vim / Neovim 兼容
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

# Python
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Conan
export CONAN_HOME="$XDG_CONFIG_HOME/conan"

# ---------------------------------------------------------
# PATH
# ---------------------------------------------------------

typeset -U path

# 用户本地可执行文件
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
)

export PATH=${(j.:.)path}

# ---------------------------------------------------------
# 历史记录优化
# ---------------------------------------------------------

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# ---------------------------------------------------------
# Powerlevel10k instant prompt
# ---------------------------------------------------------

if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------------------------------------
# Oh My Zsh
# ---------------------------------------------------------

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE=true
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$HOST"

plugins=(
  git
  fzf
  fzf-tab
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-vi-mode
)

source "$ZSH/oh-my-zsh.sh"

[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# ---------------------------------------------------------
# Zsh vi mode
# ---------------------------------------------------------

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_KEYTIMEOUT=0.3

function zvm_config() {
  ZVM_INSERT_MODE_CURSOR=$'\e[5 q'
  ZVM_NORMAL_MODE_CURSOR=$'\e[1 q'
}

function zvm_after_init() {
  zvm_bindkey vicmd 'dL' kill-line

  zvm_bindkey vicmd 'H' beginning-of-line
  zvm_bindkey vicmd 'L' end-of-line

  zvm_bindkey visual 'H' beginning-of-line
  zvm_bindkey visual 'L' end-of-line
}

# ---------------------------------------------------------
# Alias
# ---------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -al'
alias ll='ls -alFh'
alias lt='ls -ltrh'
alias cls='clear'

# tmux
alias tl='tmux list-sessions'
alias tkss='tmux kill-session -t'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tm='tmux'

# config
alias zshconfig='vim "$ZDOTDIR/.zshrc"'
alias zshenvconfig='vim "$HOME/.zshenv"'
alias zshreload='source "$ZDOTDIR/.zshrc"'
alias tmuxconfig='vim "$XDG_CONFIG_HOME/tmux/tmux.conf"'
alias tmuxreload='tmux source-file "$XDG_CONFIG_HOME/tmux/tmux.conf"'

# process / disk
alias psg='ps aux | grep -i'
alias df='df -h'
alias du='du -h --max-depth=1'

# WSL 常用
alias explorer='explorer.exe .'
alias clip='clip.exe'

# ---------------------------------------------------------
# zoxide
# ---------------------------------------------------------

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ---------------------------------------------------------
# fzf（如果你用的是官方安装脚本）
# ---------------------------------------------------------

[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f "$ZDOTDIR/.fzf.zsh" ]] && source "$ZDOTDIR/.fzf.zsh"
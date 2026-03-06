# =========================================================
# ~/.config/zsh/.zshrc
# =========================================================

# =========================================================
# 全局环境变量
# =========================================================

# Oh-My-Zsh
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/oh-my-zsh"

# 全局缓存/状态重定向
export NUGET_PACKAGES="$XDG_CACHE_HOME/nuget"
export TMUX_TMPDIR="$XDG_CACHE_HOME"
export LESSHISTFILE="$XDG_CACHE_HOME/less"

# Vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

# Python
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
# export CONDARC="$HOME/.conda/condarc"

# Conan
export CONAN_HOME="$XDG_CONFIG_HOME/conan"

# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_PIP_INDEX_URL="https://pypi.mirrors.ustc.edu.cn/simple"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# VS Code CLI
export VSCODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# =========================================================
# PATH / 编译环境
# =========================================================

typeset -U path
path=(
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$VSCODE_BIN"
  $path
)

export PATH=${(j.:.)path}
export CPATH="$HOMEBREW_PREFIX/include${CPATH:+:$CPATH}"
export LIBRARY_PATH="$HOMEBREW_PREFIX/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"

# =========================================================
# 历史记录
# =========================================================

export HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

# =========================================================
# Powerlevel10k instant prompt
# 尽量靠前，且放在不会产生交互输入的代码之后
# =========================================================

if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================================================
# Oh My Zsh
# =========================================================

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

# Powerlevel10k 配置
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# =========================================================
# Zsh VI Mode
# =========================================================

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

# =========================================================
# Alias
# =========================================================

alias ..="cd .."
alias l="ls -al"
alias ll="ls -alFh"
alias lt="ls -ltrh"
alias cls="clear"

# tmux
alias tl="tmux list-sessions"
alias tkss="tmux kill-session -t"
alias ta="tmux attach -t"
alias ts="tmux new-session -s"

# config
alias zshconfig='vim "$ZDOTDIR/.zshrc"'

# process / disk
alias psg='ps aux | grep -i'
alias df='df -h'
alias du='du -h -d 1'

# =========================================================
# Conda
# =========================================================

# __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#   eval "$__conda_setup"
# else
#   if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#     . "/opt/miniconda3/etc/profile.d/conda.sh"
#   else
#     export PATH="/opt/miniconda3/bin:$PATH"
#   fi
# fi
# unset __conda_setup

# =========================================================
# 其他工具
# =========================================================

eval "$(zoxide init zsh)"
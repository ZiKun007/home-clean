# =========================================================
# ~/.config/zsh/.zshrc
# Optimized for macOS (Apple Silicon / Intel)
# =========================================================

# ---------------------------------------------------------
# 1. Powerlevel10k instant prompt (必须在最前面)
# ---------------------------------------------------------
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------------------------------------
# 2. 基础目录与缓存配置
# ---------------------------------------------------------
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/oh-my-zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/.less_history"
export TMUX_TMPDIR="$XDG_CACHE_HOME/tmux"
export NUGET_PACKAGES="$XDG_CACHE_HOME/nuget"
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"

mkdir -p "$ZSH_CACHE_DIR" "$TMUX_TMPDIR" "$(dirname "$HISTFILE")" "$(dirname "$LESSHISTFILE")" "$UV_CACHE_DIR" 2>/dev/null

export DISABLE_AUTO_TITLE=true

# ---------------------------------------------------------
# 3. 历史记录优化
# ---------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# ---------------------------------------------------------
# 4. macOS 专属环境与 PATH
# ---------------------------------------------------------
# Homebrew (确保 Apple Silicon 和 Intel 兼容)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_PIP_INDEX_URL="https://pypi.mirrors.ustc.edu.cn/simple"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# VS Code CLI
export VSCODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# 组装 PATH
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$VSCODE_BIN"
  "$HOME/.cargo/bin"
  $path
)

# uv 工具兜底
[[ -d "$HOME/.local/share/uv/tools" ]] && path=("$HOME/.local/share/uv/tools" $path)

export PATH=${(j.:.)path}

# 编译相关环境变量 (C++)
export CPATH="$HOMEBREW_PREFIX/include${CPATH:+:$CPATH}"
export LIBRARY_PATH="$HOMEBREW_PREFIX/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"

# 开发工具配置
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/.vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export CONAN_HOME="$XDG_CONFIG_HOME/conan"

# ---------------------------------------------------------
# 5. Oh My Zsh 核心与插件
# ---------------------------------------------------------
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE=true
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$HOST"

# 将补全缓存交接给 Oh My Zsh 处理，只保留样式设置
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

plugins=(
  git
  fzf
  fzf-tab
  zsh-autosuggestions
  zsh-vi-mode
  fast-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# ---------------------------------------------------------
# 6. 插件深度配置 (Vi Mode / Fzf / Zoxide)
# ---------------------------------------------------------
# Zsh vi mode
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

# Zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Fzf
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f "$ZDOTDIR/.fzf.zsh" ]] && source "$ZDOTDIR/.fzf.zsh"

# ---------------------------------------------------------
# 7. Conda 初始化 (已去重)
# ---------------------------------------------------------
if [[ -d "/opt/miniconda3" ]] || [[ -d "$HOME/miniconda3" ]]; then
  if [[ -x "/opt/miniconda3/bin/conda" ]]; then
    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  elif [[ -x "$HOME/miniconda3/bin/conda" ]]; then
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  fi

  if [[ -n "$__conda_setup" ]]; then
    eval "$__conda_setup"
  else
    [[ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]] && . "/opt/miniconda3/etc/profile.d/conda.sh"
    [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]] && . "$HOME/miniconda3/etc/profile.d/conda.sh"
  fi
  unset __conda_setup
fi

# ---------------------------------------------------------
# 8. Alias
# ---------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -al'
alias ll='ls -alFh'
alias lt='ls -ltrh'
alias cls='clear'

# tmux
alias tm='tmux'
alias tl='tmux list-sessions'
alias tkss='tmux kill-session -t'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# config (已适配 macOS 路径)
alias zshconfig='vim "$ZDOTDIR/.zshrc"'
alias zshenvconfig='vim "$HOME/.zshenv"'
alias zshreload='source "$ZDOTDIR/.zshrc"'
alias tmuxconfig='vim "$XDG_CONFIG_HOME/tmux/tmux.conf"'
alias tmuxreload='tmux source-file "$XDG_CONFIG_HOME/tmux/tmux.conf"'

# process / disk (macOS 使用 -d 1 代替 --max-depth)
alias psg='ps aux | grep -i'
alias df='df -h'
alias du='du -h -d 1'

# Python / uv
alias py='python'
alias venv='uv venv'
alias urun='uv run'
alias uadd='uv add'
alias usync='uv sync'

# =========================================================
# 其他工具
# =========================================================
eval "$(zoxide init zsh)"

export PATH=${(j.:.)path}

# tmux
[ -f "XDG_CONFIG_HOME/tmux/tmux.conf" ] && tmux source-file "XDG_CONFIG_HOME/tmux/tmux.conf"
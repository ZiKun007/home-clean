# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 主题设置
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# 核心功能设置
DISABLE_AUTO_UPDATE=true  # 禁用自动更新
ZSH_COMPDUMP=$ZSH_CACHE_DIR/.zcompdump-$HOST

# 环境变量设置
export HOMEBREW_PREFIX="/opt/homebrew"
export VSCODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# 正确设置PATH（使用数组确保路径安全）
typeset -U path  # 确保PATH唯一性
path=(
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    "$VSCODE_BIN"
    $path  # 保留原有PATH
)

# 将数组转换为PATH环境变量
export PATH=${(j.:.)path}

# 设置其他开发环境变量
export CPATH="$HOMEBREW_PREFIX/include:$CPATH"
export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LIBRARY_PATH"


# oh my zsh 插件
plugins=(
  git               # Git 增强命令
  fzf
  fzf-tab
  zsh-autosuggestions   # 命令建议
  fast-syntax-highlighting  # 语法高亮
  zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# ZSH VI Mode Begin---------------------------------------------------
# Vim 模式设置
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_KEYTIMEOUT=0.3
function zvm_config() {
  # Insert：闪烁竖线
  ZVM_INSERT_MODE_CURSOR=$'\e[5 q'  
  # Normal：闪烁方块
  ZVM_NORMAL_MODE_CURSOR=$'\e[1 q'  
}
# 自定义按键绑定
function zvm_after_init() {
  zvm_bindkey vicmd 'dL' kill-line  # 删除到行尾

  # Normal 模式
  zvm_bindkey vicmd 'H' beginning-of-line
  zvm_bindkey vicmd 'L' end-of-line

  
  # Visual 模式
  zvm_bindkey visual 'H' beginning-of-line
  zvm_bindkey visual 'L' end-of-line
}
# ZSH VI MODE END--------------------------------------------------------


# 命令别名 BEGIN------------------------------------------------
alias ..="cd .."
alias l="ls -al"
alias ll='ls -alFh'                # 详细列表
alias lt='ls -ltrh'                # 按时间倒序（最近修改在后）
alias cls="clear"
alias tl="tmux list-sessions"
alias tkss="tmux kill-session -t"
alias ta="tmux attach -t"
alias ts="tmux new-session -s"
alias zshconfig="vim $ZDOTDIR/.zshrc"

# 进程管理
alias psg='ps aux | grep -i'

# 磁盘空间
alias df='df -h'
alias du='du -h -d 1'
# 命令别名 END--------------------------------------------------


# >>> conda initialize >>>
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(zoxide init zsh)"   # 目录快捷跳转


# 创建统一的 XDG 目录结构
typeset -gU config_dirs=(~/.config ~/.cache ~/.local/{share,state})
for dir in $config_dirs; do
  [[ -d $dir ]] || mkdir -p $dir
done

# 动态重定向核心路径
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="$HOME/.config/zsh"

# 全局重定向
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget"
export TMUX_TMPDIR="${XDG_CACHE_HOME}"

# VIM 设置
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

# Less历史
export LESSHISTFILE="${XDG_CACHE_HOME}/less"

# Homebrew 相关
export HOMEBREW_PIP_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple #ckbrew
export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api  #ckbrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles #ckbrew

# Python 相关
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# 启用颜色支持
export CLICOLOR=1
export LSCOLORS="ExFxBxDxCxegedabagacad"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# 环境配置
source "$ZDOTDIR/init.zsh"

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

# Oh-My-Zsh 设置
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/oh-my-zsh"

# 全局重定向
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget"
export TMUX_TMPDIR="${XDG_CACHE_HOME}"

# VIM 设置
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="${XDG_CONFIG_HOME}/vim"

# Less历史
export LESSHISTFILE="${XDG_CACHE_HOME}/less"

# Homebrew 相关
export HOMEBREW_PIP_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple #ckbrew
export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api  #ckbrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles #ckbrew

# Python 相关
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
#export CONDARC="${HOME}/.conda/condarc"

# C++ 包管理器
export CONAN_HOME="${XDG_CONFIG_HOME}/conan"

# 启用颜色支持
#export CLICOLOR=1
#export LSCOLORS="ExFxBxDxCxegedabagacad"

# 历史记录设置
export HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000                    # 内存中保存的历史命令数量
SAVEHIST=10                       # 历史记录文件保存数量
# 去重配置：不保存重复命令
setopt HIST_SAVE_NO_DUPS          # 保存命令时跳过重复
setopt HIST_REDUCE_BLANKS         # 删除多余空格
setopt share_history		          # 多个实例共享历史记录
setopt hist_ignore_dups		        # 不记录多条连续重复的历史
setopt hist_reduce_blanks	        # 删除历史记录中的空行
setopt hist_find_no_dups	        # 查找历史记录时忽略重复项
setopt hist_ignore_space	        # 不记录空格开头的命令

# 环境配置
source "$ZDOTDIR/.zshrc"

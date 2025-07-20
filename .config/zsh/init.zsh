#!/usr/bin/env zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# 定义成函数，方便在plugins.zsh中进行冷启动，避免影响zsh启动速度
conda_init(){
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
}
# <<< conda initialize <<<

source "$(brew --prefix)/opt/zinit/zinit.zsh"

# --- 核心路径定义 ---
# 环境变量设置
export LANG=zh_CN.UTF-8

typeset -U path # 确保PATH唯一
# 系统路径
path=(
  /usr/bin
  /usr/local/bin
  /opt/homebrew/{bin,sbin}
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  $path
)

# C/C++ 开发路径
export CPATH="/opt/homebrew/include:$CPATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"

# --- 加载顺序控制 ---
zsh_config_files=(
  alias.zsh
  plugins.zsh   # 设置conda_init()函数冷启动
)

# 动态加载所有配置文件
for file in $zsh_config_files; do
  source "${ZDOTDIR}/${file}"
done

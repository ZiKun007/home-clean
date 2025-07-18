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

# 历史记录设置
HISTSIZE=10000                    # 内存中保存的历史命令数量
SAVEHIST=10                       # 历史记录文件保存数量

# 去重配置：不保存重复命令
# setopt HIST_IGNORE_ALL_DUPS       # 跳过重复命令（包括连续和非连续的重复）
setopt HIST_SAVE_NO_DUPS          # 保存命令时跳过重复
setopt HIST_REDUCE_BLANKS         # 删除多余空格

eval $(/opt/homebrew/bin/brew shellenv) #ckbrew
source "$(brew --prefix)/opt/zinit/zinit.zsh"

# --- 加载顺序控制 ---
zsh_config_files=(
  env.zsh
  alias.zsh
  plugins.zsh   # 设置conda_init()函数冷启动
)

# 动态加载所有配置文件
for file in $zsh_config_files; do
  source "${ZDOTDIR}/${file}"
done

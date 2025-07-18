#!/usr/bin/env zsh

# ===== ZINIT 插件配置 =====
zinit ice wait"1" lucid atinit='conda_init'   # conda环境冷启动
zinit light zdharma-continuum/null

# Powerlevel10k 主题
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 语法高亮
zle -N menu-search
zle -N recent-paths
zinit light zdharma/fast-syntax-highlighting

# man 手册高亮，示例（蓝色）
zinit light ael-code/zsh-colored-man-pages

# 自动补全
zinit light zsh-users/zsh-autosuggestions

# 增强版补全系统
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-history-substring-search  # 历史搜索（↑↓ 键触发）

# 历史搜索 + fzf 整合
zinit light Aloxaf/fzf-tab
zinit light joshskidmore/zsh-fzf-history-search

# Git 增强
zinit light wfxr/forgit

# docker 命令补全
zinit ice wait lucid blockf
zinit light greymd/docker-zsh-completion

# ZSH VI Mode ----------------------------------------
zinit light jeffreytse/zsh-vi-mode
# Vim 模式设置
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_KEYTIMEOUT=0.3
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
# ZSH VI MODE--------------------------------------------------------


# 启用 fzf
[ -f "${XDG_CONFIG_HOME}/zsh/.fzf.zsh" ] && source "${XDG_CONFIG_HOME}/zsh/.fzf.zsh"


# --- Powerlevel10k 即时提示 ---
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Powerlevel10k 主题初始化（首次运行会引导配置）
if [[ ! -f "${XDG_CONFIG_HOME}/zsh/.p10k.zsh" ]]; then
  p10k configure
fi
source "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"
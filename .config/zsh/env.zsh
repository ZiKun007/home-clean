#!/usr/bin/env zsh

# --- 语言设置 ---
export LANG=zh_CN.UTF-8

# --- 核心路径定义 ---
typeset -U path # 确保PATH唯一

# 系统路径
path=(
  /usr/bin
  /usr/local/bin
  /opt/homebrew/{bin,sbin}
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  $path
)

# --- 开发环境路径 ---
# C/C++ 开发路径
export CPATH="/opt/homebrew/include:$CPATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"


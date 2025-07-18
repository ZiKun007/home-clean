#!/usr/bin/env zsh

alias l="ls -al"
alias ll='ls -alFh'                # 详细列表
alias lt='ls -ltrh'                # 按时间倒序（最近修改在后）
alias cls="clear"
alias tl="tmux list-sessions"
alias tkss="tmux kill-session -t"
alias ta="tmux attach -t"
alias ts="tmux new-session -s"

# 进程管理
alias psg='ps aux | grep -i'

# 磁盘空间
alias df='df -h'
alias du='du -h -d 1'

# 🛠️ home-clean: High-Efficiency Linux Development Environment

[![OS](https://img.shields.io/badge/OS-Ubuntu%2020.04%2F22.04-orange?logo=ubuntu)](https://ubuntu.com/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-blue?logo=gnu-bash)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/Editor-Vim-green?logo=vim)](https://www.vim.org/)
[![Multiplexer](https://img.shields.io/badge/Multiplexer-Tmux-black?logo=tmux)](https://github.com/tmux/tmux)

`home-clean` 是一个专为 SLAM、机器人开发及高性能 C++ 工程师 打造的 Linux 环境快速配置方案。它将原本混乱的 `$HOME` 目录变得整洁有序，通过高度自动化的脚本，一键安装系统依赖并构建基于 `Zsh + Tmux + Vim` 的硬核开发流。

## 🌟 核心特性 (Key Features)

- **一键部署 (One-Click Setup):** 通过 `setup.sh` 自动调用 `apt` 安装必备软件（Zsh, Tmux, Vim, Zoxide 等），并完成软链接映射及插件配置。
- **高效 Shell 体验:** 基于 Zsh，预装语法高亮与自动建议补全，配合 `zoxide` (z) 实现目录秒级智能跳转。
- **终端复用:** 精心配置的 Tmux 方案，支持鼠标操作、一键分屏及会话保持，极大提升远程调试效率。
- **轻量级编辑:** 针对 C++ 开发优化的纯 Vim 配置，支持基础语法高亮，拒绝臃肿。
- **SLAM 友好:** 包含常用的 CMake、GDB 调试别名及 ROS 环境变量快速加载脚本。

## 📂 仓库结构 (Directory Structure)

```text
home-clean/
├── LICENSE
├── README.md
├── config/             # 存放应用核心配置
│   ├── fonts/          # 终端极客字体 (Nerd Fonts 等)
│   ├── tmux/           # Tmux 详细配置与插件
│   ├── vim/            # Vim 纯净版配置
│   └── zsh/            # Zsh 主题与别名配置
├── local/              # 存放本地数据与状态
│   ├── share/
│   └── state/
├── .zshenv             # Zsh 环境变量入口
├── .tmux.conf          # Tmux 主配置文件
└── setup.sh            # 主入口部署与安装脚本
```

## 🚀 快速开始 (Quick Start)

> **警告:** 执行前建议备份原有的 `.zshrc` 或 `.tmux.conf`。

注意: setup.sh 会自动请求 sudo 权限以安装系统依赖。脚本内置安全机制，会自动将你原有的配置备份到 ~/.dotfiles_backup 目录下，不会产生破坏性覆盖。

```bash
# 1. 克隆仓库
git clone https://github.com/ZiKun007/home-clean.git
cd home-clean

# 2. 赋予脚本执行权限
chmod +x setup.sh

# 3. 开始自动部署
./setup.sh
```
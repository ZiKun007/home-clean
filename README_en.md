<div align="right">
  <a href="README.md">中文</a> | <strong>English</strong>
</div>

# 🛠️ home-clean: High-Efficiency Linux Development Environment

[![OS](https://img.shields.io/badge/OS-Ubuntu%2020.04%2F22.04-orange?logo=ubuntu)](https://ubuntu.com/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-blue?logo=gnu-bash)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/Editor-Vim-green?logo=vim)](https://www.vim.org/)
[![Multiplexer](https://img.shields.io/badge/Multiplexer-Tmux-black?logo=tmux)](https://github.com/tmux/tmux)

`home-clean` is a fast and automated Linux environment configuration solution designed specifically for **SLAM researchers, robotics developers, and high-performance C++ engineers**. It transforms a chaotic `$HOME` directory into an organized workspace, building a hardcore development workflow based on `Zsh + Tmux + Vim` via a one-click deployment script.

## 🌟 Key Features

- **One-Click Setup:** Uses `setup.sh` to automatically install dependencies via `apt` (Zsh, Tmux, Vim, Zoxide, fontconfig), configure Nerd Fonts, and safely establish symlinks.
- **Efficient Shell Experience:** Zsh-based with syntax highlighting and auto-suggestions. Integrated with `zoxide` (z) for smart, sub-second directory jumping.
- **Terminal Multiplexing:** Carefully crafted Tmux configuration supporting mouse operations, quick pane splitting, and session persistence, significantly boosting remote debugging efficiency.
- **Lightweight Editing:** A pure Vim configuration optimized for C++ development with essential syntax highlighting, strictly rejecting bloat.
- **SLAM-Friendly:** Includes common aliases for CMake, GDB debugging, and quick-load scripts for ROS workspaces.

## 📂 Directory Structure

```text
home-clean/
├── LICENSE
├── README.md           # Chinese Documentation
├── README_en.md        # English Documentation
├── config/             # Core configurations
│   ├── fonts/          # Nerd Fonts for terminal UI
│   ├── tmux/           # Tmux configs and plugins
│   ├── vim/            # Pure Vim setup
│   └── zsh/            # Zsh themes and aliases
├── local/              # Local data and states
│   ├── share/
│   └── state/
├── .zshenv             # Zsh environment variables entry
├── .tmux.conf          # Main Tmux configuration file
└── setup.sh            # Main deployment and installation script
```

## 🚀 Quick Start
Note: setup.sh will prompt for sudo privileges to install system packages. The script features a built-in safety mechanism that automatically backs up your existing configurations to ~/.dotfiles_backup to prevent any destructive overwrites.

```bash
# 1. Clone the repository
git clone https://github.com/ZiKun007/home-clean.git
cd home-clean

# 2. Grant execution permissions
chmod +x setup.sh

# 3. Run the automated deployment
./setup.sh
```
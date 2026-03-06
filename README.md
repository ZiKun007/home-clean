# 使用说明

1. `main` 分支为zinit的配置，实际使用体验不如oh-my-zsh

2. Ubuntu 系统使用 `ubuntu` 分支的配置

3. MacOS 系统使用 `macos` 分支的配置

4. tmux的使用需要先到 `tmux/plugins` 目录下安装 tpm 插件管理器
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

5. python 相关的配置在 `zsh/.zshrc` 中，如果使用 uv 作为 python 包管理器，需要删除 `zsh/.zshrc` 中关于 `conda` 的配置
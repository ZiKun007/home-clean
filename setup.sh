#!/bin/bash

# ==============================================================================
# home-clean 环境部署脚本
# ==============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}>>> 开始部署 home-clean 环境配置...${NC}"

# ==========================================
# 0. 检查并安装系统依赖
# ==========================================
echo -e "\n${BLUE}>>> 0. 安装基础系统依赖 (需要 sudo 权限)...${NC}"
sudo apt update
sudo apt install -y zsh tmux vim git curl wget tree xclip fontconfig

# 安装 zoxide (新一代 cd 命令)
if ! command -v zoxide &> /dev/null; then
    echo -e "${YELLOW}  [安装] 正在获取 zoxide...${NC}"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo -e "${GREEN}  [OK] zoxide 已安装${NC}"
fi

# ==========================================
# 准备目标基础目录
# ==========================================
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local"
mkdir -p "$HOME/.local/share/fonts"

# ==========================================
# 核心函数：安全备份并创建软链接
# ==========================================
safe_link() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo -e "${YELLOW}  [跳过] 源文件不存在: $src${NC}"
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" == "$src" ]; then
            echo -e "${GREEN}  [OK] 已经链接: $dest${NC}"
            return
        fi
        
        mkdir -p "$BACKUP_DIR"
        echo -e "${YELLOW}  [备份] 发现现有配置，移动 $dest -> $BACKUP_DIR/${NC}"
        mv "$dest" "$BACKUP_DIR/"
    fi

    ln -s "$src" "$dest"
    echo -e "${GREEN}  [链接] $src -> $dest${NC}"
}

# ==========================================
# 1. 处理 config 下的文件夹 (除 fonts 外)
# ==========================================
echo -e "\n${BLUE}>>> 1. 部署 .config 目录...${NC}"
for folder in "$DOTFILES_DIR"/config/*; do
    if [ -d "$folder" ]; then
        base_name=$(basename "$folder")
        # 字体由于系统读取路径问题，我们在后面单独处理
        if [ "$base_name" == "fonts" ]; then
            continue
        fi
        safe_link "$folder" "$HOME/.config/$base_name"
    fi
done

# ==========================================
# 2. 处理 local 下的文件夹
# ==========================================
echo -e "\n${BLUE}>>> 2. 部署 .local 目录...${NC}"
for folder in "$DOTFILES_DIR"/local/*; do
    if [ -d "$folder" ]; then
        base_name=$(basename "$folder")
        safe_link "$folder" "$HOME/.local/$base_name"
    fi
done

# ==========================================
# 3. 处理根目录的单文件
# ==========================================
echo -e "\n${BLUE}>>> 3. 部署根目录配置文件...${NC}"
safe_link "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
safe_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# ==========================================
# 4. 处理系统字体与缓存
# ==========================================
echo -e "\n${BLUE}>>> 4. 部署终端极客字体...${NC}"
if [ -d "$DOTFILES_DIR/config/fonts" ]; then
    # 将字体目录软链接到标准系统用户字体路径下
    safe_link "$DOTFILES_DIR/config/fonts" "$HOME/.local/share/fonts/home-clean-fonts"
    echo -e "${YELLOW}  [刷新] 正在重置系统字体缓存，请稍候...${NC}"
    fc-cache -fv > /dev/null
    echo -e "${GREEN}  [OK] 字体缓存已刷新${NC}"
else
    echo -e "${YELLOW}  [跳过] 未在仓库中找到 config/fonts 目录${NC}"
fi

# ==========================================
# 5. 切换默认 Shell
# ==========================================
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "\n${YELLOW}>>> 将 Zsh 设置为默认 Shell...${NC}"
    chsh -s "$(which zsh)"
    echo -e "${GREEN}  设置完成，重新登录后生效。${NC}"
fi

# ==========================================
# 完成提示
# ==========================================
echo -e "\n${GREEN}>>> 🎉 部署完成！${NC}"
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR")" ]; then
    echo -e "所有被替换的旧系统配置已安全备份至: ${YELLOW}$BACKUP_DIR${NC}"
fi
echo -e "请执行 ${YELLOW}source ~/.zshenv${NC} 或直接重启终端以加载新环境。"
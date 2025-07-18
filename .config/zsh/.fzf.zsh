# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/Cellar/fzf/0.64.0/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/Cellar/fzf/0.64.0/bin"
fi

source <(fzf --zsh)

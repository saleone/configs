OS_NAME="$(uname -s)"

# ENV variables
export NEXT_TELEMETRY_DISABLED=1

# Brew
if [ "$OS_NAME" = "Darwin" ]; then
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

# Ensure we have out local binaries dir
if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH

# Load secrets
if [ ! -f $HOME/.env ]; then touch $HOME/.env; fi
source "$HOME/.env"

# Functions
workon () {
  # TODO: Maybe a faster way than actually starting up Python?
  local workonPath="$HOME/Dev/$(python3 -c "print('$1'.capitalize())")/$2"
  if [ ! -d $workonPath ]; then
    echo "Workon path does not exist."
    return 1
  fi
  cd $workonPath

  if [ ! -d "$HOME/.workons" ]; then mkdir "$HOME/.workons"; fi

  local initPath="$HOME/.workons/$1_$2_workon_init"
  if [ !  -f $initPath ]; then
    touch $initPath
    chmod +x $initPath
    echo "Workon init file does not exist. Initialized empty $initPath."
    return 2
  fi

  source $initPath
}

# Aliases
alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

# Kubernetes
alias kubep="kubectl -n homelab-prod"
alias kubed="kubectl -n homelab-dev"

# Git
alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitl="git log --oneline --graph --decorate"
alias gitb="git branch"
alias gitd="git diff"
alias gitf="git fetch"
alias gitco="git checkout"
alias gitcb="git checkout -b"

# Containers
alias docker="podman"


# Node
export NVM_DIR="$HOME/.nvm"
if [ "$OS_NAME" = "Darwin" ]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  # Linux
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if ! command -v nvm &> /dev/null; then
  if [ "$OS_NAME" = "Darwin" ]; then
    brew install nvm
  else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  fi
  nvm install --lts
fi

# Python
if ! command -v uv &> /dev/null; then
  if [ "$OS_NAME" = "Darwin" ]; then
    brew install uv
  else
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi
  uv python install
fi

# Rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
if ! command -v cargo &> /dev/null; then
  # TODO: Make this run without user input.
  # All defaults excpet adding cargo to env which is done below.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Go
if ! command -v go &> /dev/null; then
  if [ "$OS_NAME" = "Darwin" ]; then
    brew install go
  else
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
  fi
fi
export PATH=$PATH:$(go env GOPATH)/bin

# Start up SSH agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s) > /dev/null 2>&1
fi

zle-keymap-select () {
  case $KEYMAP in
    vicmd) print -rn -- $terminfo[cvvis];; # block cursor
    viins|main) print -rn -- $terminfo[cnorm];; # less visible cursor
  esac
}

# Enable vim keybinds
if [ -n "$ZSH_VERSION" ]; then
  bindkey -v
fi

if [ -n "$BASH_VERSION" ]; then
  set -o vi
fi

# Prompt
build_prompt () {
  # Define constants based on the shell
  if [ -n "$ZSH_VERSION" ]; then
    HOSTNAME_COLOR="%F{green}"
    USERNAME_COLOR="%F{blue}"
    DIR_COLOR="%F{yellow}"
    PROMPT_COLOR="%F{cyan}"
    RESET_COLOR="%f"
    PROMPT_SYMBOL="%#"
  elif [ -n "$BASH_VERSION" ]; then
    HOSTNAME_COLOR="\[\e[32m\]"
    USERNAME_COLOR="\[\e[34m\]"
    DIR_COLOR="\[\e[33m\]"
    PROMPT_COLOR="\[\e[36m\]"
    RESET_COLOR="\[\e[0m\]"
    PROMPT_SYMBOL="\$"
  fi

  local prompt=""

  if [ ! "$(hostname)" = "SasaS-MBP14-MPKQW6PDQF-8B49" ]; then
    prompt+="${HOSTNAME_COLOR}$(hostname):${RESET_COLOR}"
  fi

  if [ ! "$(whoami)" = "saleone" ]; then
    prompt+="${USERNAME_COLOR}\u${RESET_COLOR}@"
  fi

  if [ -n "$ZSH_VERSION" ]; then
    prompt+="%{${DIR_COLOR}%}%~%{${RESET_COLOR}%} "
  else
    prompt+="${DIR_COLOR}\w${RESET_COLOR} "
  fi

  # Prompt symbol
  prompt+="${PROMPT_COLOR}${PROMPT_SYMBOL}${RESET_COLOR} "

  echo "$prompt"
}

# Set the prompt
export PS1="$(build_prompt)"

OS_NAME="$(uname -s)"

# Ensure we have out local binaries dir
if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH

# Load secrets
if [ ! -f $HOME/.env_configs ]; then touch $HOME/.env_configs; fi
source "$HOME/.env_configs"

# Functions
workon () {
  local workonPath="$HOME/Dev/$(python3 -c "print('$1'.capitalize())")/$2"
  cd $workonPath
  if [ -f "$workonPath/.init-workon" ]; then
    source $workonPath/.init-workon
  fi
}

builder () {
  local venvDir="$HOME/Dev/Stem/Tools/builder"

  # Install builder if not already installed
  if [ ! -d "$venvDir" ]; then
    echo "Installing stem-builder"
    mkdir -p $venvDir
    python3 -m venv $venvDir
	 $venvDir/bin/pip install --extra-index-url https://nexus.stem.com/repository/stem-pypi/simple stem-builder
  fi

  local dateFile="/tmp/stem-builder-update-date"
  local today=$(date "+%Y-%m-%d")

  # Update builder if not updated today. Updates also when the temp files are deleted.
  if [[ ! -f "$dateFile" ]] || ! grep -q "$today" "$dateFile"; then
    echo "Updating stem-builder"
	 $venvDir/bin/pip install --extra-index-url \
				https://nexus.stem.com/repository/stem-pypi/simple --upgrade stem-builder
      echo "$today" > "$dateFile"
  fi

  # Need to activate venv to have tox available
  source $venvDir/bin/activate;
  stem-builder $@;
  deactivate;

}


# Aliases
alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

alias ks="kubectl"
alias aws-login="aws --profile dev sso login"

alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitl="git log --oneline --graph --decorate"
alias gitb="git branch"
alias gitd="git diff"
alias gitf="git fetch"
alias gitco="git checkout"
alias gitcb="git checkout -b"


# Paths updates
export NVM_DIR="$HOME/.nvm"

if [ "$OS_NAME" = "Darwin" ]; then
  export CPATH=/opt/homebrew/include
  export LIBRARY_PATH=/opt/homebrew/lib

  export PATH=$HOME/.local/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$(brew --prefix icu4c)/lib/pkgconfig"
  export HDF5_DIR=$(brew --prefix hdf5)
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  # Linux
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Setups
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

export PATH=$PATH:$(go env GOPATH)/bin

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

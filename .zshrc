OS_NAME="$(uname -s)"

# Brew
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# TODO: Move work related stuff to separate file.
# Stem
alias aws-login="aws --profile dev sso login"
builder () {
  local venvDir="$HOME/Dev/Stem/Tools/builder"

  # Install builder if not already installed
  if [ ! -d "$venvDir" ]; then
    echo "Installing stem-builder"
    mkdir -p $venvDir
    python3.11 -m venv $venvDir
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

if [ "$OS_NAME" = "Darwin" ]; then
  export CPATH=/opt/homebrew/include
  export LIBRARY_PATH=/opt/homebrew/lib

  # Translation libraries for work related stuff.
  export PATH=$HOME/.local/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$(brew --prefix icu4c)/lib/pkgconfig"
  export HDF5_DIR=$(brew --prefix hdf5)
fi

# Aliases
alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

alias ks="kubectl"

alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitl="git log --oneline --graph --decorate"
alias gitb="git branch"
alias gitd="git diff"
alias gitf="git fetch"
alias gitco="git checkout"
alias gitcb="git checkout -b"


# Node
if ! command -v node &> /dev/null; then
  brew install nvm
  nvm install --lts
fi
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

# Python
if ! command -v uv &> /dev/null; then
  brew install uv
  uv python install
fi

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Rust
if ! command -v cargo &> /dev/null; then
  # TODO: Make this run without user input.
  # All defaults excpet adding cargo to env which is done below.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Go
if ! command -v go &> /dev/null; then
  brew install go
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

# Ensure we have out local binaries dir
if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH

# Functions
builder () {
  local venvDir="/Users/saleone/Dev/Stem/Tools/builder"

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
alias ks='kubectl'

# Paths updates
if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH
export HDF5_DIR=$(brew --prefix hdf5)
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Setups
eval "$(pyenv init -)"
. "$HOME/.cargo/env"

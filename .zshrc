eval "$(pyenv init -)"

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH

builder () {
  . ~/Dev/Stem/Tools/builder/bin/activate;
  stem-builder $@;
  deactivate;
}

alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH
export HDF5_DIR=$(brew --prefix hdf5)
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib


alias ks='kubectl'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

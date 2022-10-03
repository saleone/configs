eval "$(pyenv init -)"

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH

alias ks='kubectl --kubeconfig ~/Dev/Stem/Env/kubeconfig_dev'
alias ksqa='kubectl --kubeconfig ~/Dev/Stem/Env/kubeconfig_qa'

builder () {
  . ~/Dev/Stem/Tools/builder/bin/activate;
  stem-builder $@;
  deactivate;
}

alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:/opt/homebrew/opt/icu4c/bin:/opt/homebrew/opt/icu4c/sbin:$PATH
export HDF5_DIR=$(brew --prefix hdf5)

autoload bashcompinit && bashcompinit

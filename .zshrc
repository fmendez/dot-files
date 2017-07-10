#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Customize to your needs...
source $HOME/.alias
export TMPDIR="/private/tmp"

export VISUAL=vim
export EDITOR="$VISUAL"

KEYTIMEOUT=1

function rancher {
  (eval $(docker-machine env -u); command rancher $@)
}

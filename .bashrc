# If not running interactively, do nothing
[[ $- == *i* ]] || return

export EDITOR=vim
export VISUAL="$EDITOR"
export PAGER=less

# Configure history
export HISTCONTROL=ignoreboth
export HISTIGNORE="fg:bg:jobs:history:exit:logout"
shopt -s histappend

# Make less use lesspipe for non-text files
if [ -x /usr/bin/lesspipe.sh ]; then
  export LESSOPEN='|lesspipe.sh %s'
fi


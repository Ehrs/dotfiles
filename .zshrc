# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gitfast)

source $ZSH/oh-my-zsh.sh

# User configuration
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
# PWD is max 20 characters
export PROMPT='${ret_status}%B%F{cyan}${${(%):-%20<...<%~%<<}//\//%F{magenta\}/%F{cyan\}}%f%b %{$reset_color%}'
# PWD is max 4 directories
export PROMPT='${ret_status}%B%F{cyan}${${(%):-%4~}//\//%F{magenta\}/%F{cyan\}}%f%b %{$reset_color%}'

export PATH="/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin"

zstyle ':completion:*' special-dirs true
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

source ~/.bash_zsh_common


# If not running interactively, do nothing
[[ $- == *i* ]] || return

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

. ~/.bash_zsh_common

# Configure history
export HISTCONTROL=ignoreboth
export HISTIGNORE="fg:bg:jobs:history:exit:logout"
shopt -s histappend

# Make less use lesspipe for non-text files
if [ -x /usr/bin/lesspipe.sh ]; then
  export LESSOPEN='|lesspipe.sh %s'
fi

# Change window title
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnom*|interix)
    PROMPT_COMMAND='myPWD="${PWD/#$HOME/~}"; if [ ${#myPWD} -gt 30 ]; then shortPWD="${myPWD:0:12}...${myPWD:${#myPWD}-15}"; else shortPWD="$myPWD}"; fi; echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${shortPWD}\007"'
    ;;
  screen)
    PROMPT_COMMAND='myPWD="${PWD/#$HOME/~}"; if [ ${#myPWD} -gt 30 ]; then shortPWD="${myPWD:0:12}...${myPWD:${#myPWD}-15}"; else shortPWD="$myPWD}"; fi; echo -ne "\033_${USER}@${HOSTNAME%%.*}:${shortPWD}\033\\"'
    ;;
esac

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS. Try to use the external file
# first to take advantage of user additions. Use internal bash
# globbing instead of external grep binary.

# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
	
	# we have colors :-)

	# Enable colors for ls, etc. Prefer ~/.dir_colors
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

  if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;35m\]\[\033[01;31m\]$?\[\033[01;35m\] \w \[\033[00m\]\$ '
  else
    PS1='\[\033[01;35m\]\[\033[01;31m\]$?\[\033[01;35m\] \w \[\033[00m\]\$ '
  fi

	alias ls="ls --color=auto"
	alias dir="dir --color=auto"
	alias grep="grep --color=auto"
	alias dmesg='dmesg --color'

	# Uncomment the "Color" line in /etc/pacman.conf instead of uncommenting the following line...!

	# alias pacman="pacman --color=auto"

else

	# show root@ when we do not have colors

	PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "

	# Use this other PS1 string if you want \W for root and \w for all other users:
	# PS1="\u@\h $(if [[ ${EUID} == 0 ]]; then echo '\W'; else echo '\w'; fi) \$([[ \$? != 0 ]] && echo \":( \")\$ "

fi

PS2="> "
PS3="> "
PS4="+ "

# Smart history up/down
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


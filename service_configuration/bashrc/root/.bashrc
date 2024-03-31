# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#alias status='systemctl status'
#alias start='systemctl start'
#alias stop='systemctl stop'
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
PS1='\e[1;34m\j\[\e[31m\[\u@\e[36m\]\H:\e[32m\w\e[31m\$\e[39m '

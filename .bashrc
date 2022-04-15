# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


PS1='\e[1;34m\[\e[31m\[\u@\e[36m\]\H:\e[32m\w\e[31m\$\e[39m '

# User specific aliases and functions
alias l='ls -al'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
export EDITOR=/usr/bin/vi
virsh list --all

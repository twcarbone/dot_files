# .bashrc
# testing
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
#if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
#then
#   PATH="$HOME/.local/bin:$HOME/bin:$PATH"
#fi
#export PATH

export PS1="\[\e[92m\]\u@\h \[\e[94m\]\w \[\e[00m\]\$ "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ll="ls -lhva --group-directories-first"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gb="git branch"

if [[ $OSTYPE == "msys" ]]; then
	alias python3="winpty python.exe"
	alias pip="winpty python.exe -m pip"
fi


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
#export PATHi

export PS1="\[\e[38;5;46m\]\u@\h \[\e[38;5;39m\]\w \[\e[00m\]\$ "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#
# Aliases

alias ll="ls -lhva --group-directories-first"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gb="git branch"

#
# Functions
ext () {
    # Usage: `ext DIR`
    # Prints each unique file extension from DIR
    find $1 -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u;
}

tot () {
    # Usage: `tot DIR`
    # Prints the total line count for all files in DIR
    find $1 -type f -exec wc -l {} \; | awk '{total += $1} END{print total}';
}

qty () {
    # Usage: `qty DIR`
    # Prints the count of files in DIR. Ignores files in `.git` directory.
    find $1 -type f -not -path "*.git/*" | wc -l;
}

if [[ $OSTYPE == "msys" ]]; then
	alias python3="winpty python.exe"
	alias python="winpty python.exe"
	alias pip="winpty python.exe -m pip"
fi


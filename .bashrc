# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#
# Prompts
#

export PS1="\[\e[38;5;46m\]\u@\h \[\e[38;5;39m\]\w \[\e[00m\]\$ "

#
# Aliases
#

# General aliases
alias ll="ls -lhva --group-directories-first --color=auto"

# git aliases
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git commit"
alias gb="git branch"
alias gr="git restore"

alias gss="git status -s"
alias gap="git add -p"
alias gdl="git diff --color=always | less -r"
alias gds="git diff --staged"
alias gba="git branch -a"
alias grs="git restore --staged"

alias gdsl="git diff --staged --color=always | less -r"

# alembic aliases
alias ac="alembic current"

#
# Functions
#

ext () {
    # Usage: `ext DIR`
    # Prints each distinct file extension from DIR as a comma-separated sequence
    find $1 -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u | sed -e :a -e '$!N; s/\n/, /; ta';
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

LS_COLORS=$LS_COLORS:'di=94'; export LS_COLORS


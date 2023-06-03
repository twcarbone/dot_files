# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#
# Prompts
#

export PS1="${BASH_PROMPT_COLOR:-\[\e[38;5;46m\]}\u@\h \[\e[38;5;39m\]\$PWD \[\e[00m\]\$ "

#
# Aliases
#

# General aliases
alias ll="ls -lhva --group-directories-first --color=auto"
alias ql="git ql"
alias cl="clear"

# Python aliases
alias py="python3"
alias py3="python3"

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
alias ah="alembic history"

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
    alias pip-install-unsafe="winpty python.exe -m pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org"
    alias pip-freeze="winpty -Xallow-non-tty -Xplain python.exe -m pip freeze"
fi

LS_COLORS=$LS_COLORS:'di=94'; export LS_COLORS


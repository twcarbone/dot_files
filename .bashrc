# .bashrc

## General

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


## Prompt

export PS1="\[\e[38;5;46m\]\u@\h \[\e[38;5;39m\]\w \[\e[00m\]\$ "


## Alias

# .gitconfig
alias ql="git ql"
alias qlg="git qlg"

# Alembic
alias ac="alembic current"
alias ah="alembic history"

# Git
alias ga="git add"
alias gap="git add -p"
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit"
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git restore"
alias grs="git restore --staged"
alias gs="git status"
alias gss="git status -s"
alias gwd="git diff --word-diff"

# System
alias cl="clear"
alias ll="ls -lhva --group-directories-first --color=auto"


## Plugins

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find . -name .git -prune -o -print'
export FZF_DEFAULT_OPTS='-m'


## Functions

ext()
{
    # Usage: ext DIR
    # List each distinct file extension from DIR, recursively
    find $1 -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
}

dir2gpg()
{
    # Usage: dir2gpg DIR
    # Creates DIR.tar.gz.gpg
    tar -czf - "$1" | gpg -c > "$1.tar.gz.gpg"
}

gg()
{
    # Usage: gg [options] <regex>
    # Performs 'git grep -En', in addition to [options]
    git grep -En "$@"
}

gdl()
{
    git diff --color=always "$@" | less -r
}

gdsl()
{
    git diff --staged --color=always "$@" | less -r
}

gsl()
{
    git show --color=always "$@" | less -r
}

ggl()
{
    # Usage: ggl [options] <regex>
    # Performs 'git grep -En', in addition to [options], piping output to 'less'
    git grep -En --color=always "$@" | less -R
}

gpg2dir()
{
    # Usage: gpg2dir DIR
    # Decrypts and restores DIR.tar.gz.gpg
    gpg -d "$1.tar.gz.gpg" | tar -xzf -
}

tot()
{
    # Usage: tot DIR
    # Prints the total line count for all files in DIR, recursively
    find $1 -type f -exec wc -l {} \; | awk '{total += $1} END{print total}';
}

qty()
{
    # Usage: qty DIR
    # Prints the count of files in DIR, recursively. Ignores files in .git directory.
    find $1 -type f -not -path "*.git/*" | wc -l;
}

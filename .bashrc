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
alias ll="ls \
    -lhva \
    --group-directories-first \
    --color=auto \
    --time-style=\"+%b %e %H:%M:%S\""


## Environment

# Less
# i = Smart-case searching
# F = Exit immediately if content fits on one screen
# R = Display colors
# X = Do not clear the screen when exiting
export LESS="iFRX"


## Plugins

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find . '\
'-name .git -prune -o '\
'-type f '\
'-not -path */.moc/* '\
'-not -path */.obj/* '\
'-not -path *.swp '\
'-print'
export FZF_DEFAULT_OPTS="-m --height=-1"


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

gl()
{
    # Usage: gl VERBOSITY [OPTIONS]
    # Git log wrapper. VERBOSITY (default 1) is a verbosity level corresponding to the
    # numeric portion of configured `--pretty` values (e.g., use `gl 1` to invoke
    # `--pretty=v1`). OPTIONS are passed to `git log`.
    git log --color=always --pretty=v${1:-1} "${@:2}" \
        | sed -e 's/\.\.[[:space:]]*$/(more)/' \
        | sed -e '/^[[:space:]]*$/d' \
        | less -FRX
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

ppcsv()
{
    # Usage: ppcsv foo.csv
    # Pretty-print a CSV file.
    column -s, -t < $1
}

tot()
{
    # Usage: tot DIR
    # Prints the total line count for all files in DIR, recursively
    find $1 -type f -exec wc -l {} \; | awk '{total += $1} END{print total}';
}

ql()
{
    # Usage: ql VERBOSITY
    # Show 30 most recent commits, passing VERBOSITY (default 1) to `gl`.
    gl ${1:-1} -30
}

qty()
{
    # Usage: qty DIR
    # Prints the count of files in DIR, recursively. Ignores files in .git directory.
    find $1 -type f -not -path "*.git/*" | wc -l;
}

sl()
{
    # Usage: sl
    # Executes `git stash list`
    git stash list
}

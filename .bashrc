# .bashrc

# ------
# Global
# ------

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# ------
# Prompt
# ------

export PS1="${BASH_PROMPT_COLOR:-\[\e[38;5;46m\]}\u@\h \[\e[38;5;39m\]\w \[\e[00m\]\$ "


# -------
# Aliases
# -------

# General
alias ll="ls -lhva --group-directories-first --color=auto"
alias cl="clear"

# Python
alias py="python3"
alias py3="python3"
alias ac="alembic current"  # alembic
alias ah="alembic history"  # alembic
if [[ $OSTYPE == "msys" ]]; then  # if using Git Bash on windows
    alias python3="winpty python.exe"
    alias python="winpty python.exe"
    alias pip="winpty python.exe -m pip"
    alias pip-install-unsafe="winpty python.exe -m pip install"\
                              "--trusted-host pypi.org"\
                              "--trusted-host pypi.python.org"\
                              "--trusted-host files.pythonhosted.org"
    alias pip-freeze="winpty -Xallow-non-tty -Xplain python.exe -m pip freeze"
fi

# Git
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git commit"
alias gb="git branch"
alias gr="git restore"
alias gg="git grep -En"
alias gss="git status -s"
alias gap="git add -p"
alias gdl="git diff --color=always | less -r"
alias gds="git diff --staged"
alias gba="git branch -a"
alias grs="git restore --staged"
alias gwd="git diff --word-diff"
alias ql="git ql"  # .gitconfig alias
alias qlg="git qlg"  # .gitconfig alias
alias gdsl="git diff --staged --color=always | less -r"


# -----
# Other
# -----

# Color directories blue
LS_COLORS=$LS_COLORS:'di=94'; export LS_COLORS

# Set up FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find . -name .git -prune -o -print'

# ---------
# Utilities
# ---------

ext () {
    # Usage: `ext DIR`
    # List each distinct file extension from DIR, recursively
    find $1 -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
}

tot () {
    # Usage: `tot DIR`
    # Prints the total line count for all files in DIR, recursively
    find $1 -type f -exec wc -l {} \; | awk '{total += $1} END{print total}';
}

qty () {
    # Usage: `qty DIR`
    # Prints the count of files in DIR, recursively. Ignores files in .git directory.
    find $1 -type f -not -path "*.git/*" | wc -l;
}

dir2gpg () {
    # Usage: `dir2gpg DIR`
    # Creates DIR.tar.gz.gpg
    tar -czf - "$1" | gpg -c > "$1.tar.gz.gpg"
}

gpg2dir () {
    # Usage: `gpg2dir DIR`
    # Decrypts and restores DIR.tar.gz.gpg
    gpg -d "$1.tar.gz.gpg" | tar -xzf -
}

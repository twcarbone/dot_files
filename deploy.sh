set -Eeuo pipefail

VIM_PLUGIN_DIR=$HOME/.vim/pack/plugins/start
GITHUB_USER=twcarbone

init_fzf()
{
    if [[ ! -d $HOME/.fzf ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
        $HOME/.fzf/install
    fi
}

init_nvm()
{
    PROFILE=/dev/null bash -c 'curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

init_personal()
{
    if [[ ! -d "$HOME/$1" ]]; then
        git clone git@github.com:${GITHUB_USER}/${1}.git
    fi
}

init_vim_plugin()
{
    # Usage: init_vim_plugin '<user>/<repository>' '<localname>'

    pushd $VIM_PLUGIN_DIR 1> /dev/null
    if [[ ! -d $(basename $1) ]]; then
        read -p "Install $1? [y/N] "
        if [[ $REPLY != 'y' ]]; then
            echo "Skipping $1"
        else
            echo -n "Installing $1 in $VIM_PLUGIN_DIR... "
            git clone --quiet git@github.com:${1}.git ${2} 1> /dev/null
            echo "Done"
        fi
    else
        echo "${VIM_PLUGIN_DIR}/$(basename $1) already exists."
    fi
    popd 1> /dev/null
}

main()
{
    cd $HOME

    ## Remove files/dirs
    rm -f  .bashrc
    rm -f  .clang-format
    rm -f  .emacs
    rm -f  .gitconfig
    rm -f  .inputrc
    rm -f  .tmux.conf
    rm -f  .vimrc
    rm -rf .fzf
    rm -rf .vim

    ## Create symlinks
    ln -s dot_files/.bashrc         .bashrc
    ln -s dot_files/.clang-format   .clang-format
    ln -s dot_files/.emacs          .emacs
    ln -s dot_files/.gitconfig      .gitconfig
    ln -s dot_files/.inputrc        .inputrc
    ln -s dot_files/.tidyrc         .tidyrc
    ln -s dot_files/.tmux.conf      .tmux.conf
    ln -s dot_files/.vimrc          .vimrc

    ## Create repositories
    init_personal 'vim-zz'
    init_fzf

    ## Create ~/.vim
    mkdir .vim
    mkdir .vim/swapfiles
    mkdir -p .vim/pack/plugins/start

    ## Create symlinks in ~/.vim

    # Files
    ln -s $HOME/dot_files/filetype.vim              .vim/filetype.vim

    # Vim standard directories
    ln -s $HOME/dot_files/vim-after                 .vim/after
    ln -s $HOME/dot_files/vim-autoload              .vim/autoload
    ln -s $HOME/dot_files/vim-colors                .vim/colors
    ln -s $HOME/dot_files/vim-ftplugin              .vim/ftplugin
    ln -s $HOME/dot_files/vim-syntax                .vim/syntax

    # Plugins
    ln -s $HOME/vim-zz                              .vim/pack/plugins/start/zz

    ## Create repositories in ~/.vim/pack/plugins/start
    init_vim_plugin 'alvan/vim-closetag' 'vim-closetag'
    init_vim_plugin 'junegunn/fzf.vim' 'vim-fzf'
    init_vim_plugin 'tpope/vim-commentary' 'vim-commentary'
    init_vim_plugin 'ycm-core/YouCompleteMe' 'vim-ycm'
    init_vim_plugin 'airblade/vim-gitgutter' 'vim-gitgutter'

    ## Install python tools
    rm -rf .pytools
    python3 -m venv .pytools
    source .pytools/bin/activate
    pip3 install -r $HOME/dot_files/.pytools-packages
    deactivate
}

main

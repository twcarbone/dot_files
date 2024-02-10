# init submodules
git -C ~/dot_files submodule update --init --recursive

# config files
rm -f .bashrc
rm -f .vimrc
rm -f .gitconfig
rm -f .tmux.conf
rm -f .clang-format
rm -f .emacs
ln -s dot_files/.bashrc .bashrc
ln -s dot_files/.vimrc .vimrc
ln -s dot_files/.gitconfig .gitconfig
ln -s dot_files/.tmux.conf .tmux.conf
ln -s dot_files/.clang-format .clang-format
ln -s dot_files/.emacs .emacs

# ~/.vim
rm -rf .vim
mkdir .vim
mkdir .vim/colors
mkdir .vim/syntax
mkdir .vim/after
mkdir .vim/after/syntax
ln -s ~/dot_files/.vim/pack ~/.vim/pack

# ~/vim-chs
if [ -d ~/vim-chs ]; then
	git -C ~/vim-chs pull origin main
else
	git clone git@github.com:twcarbone/vim-chs.git
fi
ln -s ~/vim-chs/syntax/python.vim .vim/syntax/python.vim
ln -s ~/vim-chs/colors/chs.vim .vim/colors/chs.vim
ln -s ~/vim-chs/after/syntax/python.vim .vim/after/syntax/python.vim

# colors
ln -s ~/dot_files/.vim/colors/gruber.vim .vim/colors/gruber.vim

# nvm
PROFILE=/dev/null bash -c 'curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

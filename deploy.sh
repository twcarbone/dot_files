# init submodules
git -C ~/dot_files submodule update --init --recursive

# config files
rm -f .bashrc
rm -f .vimrc
rm -f .gitconfig
rm -f .tmux.conf
ln -s dot_files/.bashrc .bashrc
ln -s dot_files/.vimrc .vimrc
ln -s dot_files/.gitconfig .gitconfig
ln -s dot_files/.tmux.conf .tmux.conf

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

# nvm
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

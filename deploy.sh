set -Eeuo pipefail

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
	local user=twcarbone

	if [[ ! -d "$HOME/${1}" ]]; then
		eval "git clone git@github.com:${user}/${1}.git"
	fi
}

main()
{
	cd $HOME

	# Remove files/dirs
	rm -f  .bashrc
	rm -f  .clang-format
	rm -f  .emacs
	rm -f  .gitconfig
	rm -f  .tmux.conf
	rm -f  .vimrc
	rm -rf .fzf
	rm -rf .vim

	# Create symlinks
	ln -s dot_files/.bashrc			.bashrc
	ln -s dot_files/.clang-format	.clang-format
	ln -s dot_files/.emacs			.emacs
	ln -s dot_files/.gitconfig		.gitconfig
	ln -s dot_files/.tmux.conf		.tmux.conf
	ln -s dot_files/.vimrc .vimrc

	# Create repositories
	init_personal 'vim-colors'
	init_personal 'vim-syntax'
	init_personal 'vim-zz'
	# init_nvm [TODO: Do we still want nvm?]
	init_fzf

	# Create ~/.vim
	mkdir .vim
	mkdir .vim/colors
	mkdir .vim/syntax
	mkdir -p .vim/after/syntax
	mkdir -p .vim/pack/plugins/start

	# Create symlinks in ~/.vim
	ln -s $HOME/vim-colors/chs.vim					.vim/colors/chs.vim
	ln -s $HOME/vim-colors/gruber.vim				.vim/colors/gruber.vim
	ln -s $HOME/vim-syntax/syntax/python.vim		.vim/syntax/python.vim
	ln -s $HOME/vim-syntax/after/syntax/python.vim	.vim/after/syntax/python.vim
	ln -s $HOME/vim-zz								.vim/pack/plugins/start/zz
}

main

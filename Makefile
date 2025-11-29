.PHONY: install dotfiles pytools

install: dotfiles pytools

dotfiles:
	rm -f $$HOME/.emacs
	rm -f $$HOME/.bashrc
	rm -f $$HOME/.inputrc
	rm -f $$HOME/.gitconfig
	rm -f $$HOME/.tmux.conf
	ln -s $$PWD/.emacs $$HOME/.emacs
	ln -s $$PWD/.bashrc $$HOME/.bashrc
	ln -s $$PWD/.inputrc $$HOME/.inputrc
	ln -s $$PWD/.gitconfig $$HOME/.gitconfig
	ln -s $$PWD/.tmux.conf $$HOME/.tmux.conf

pytools:
	rm -rf $$HOME/.pytools
	python3 -m venv $$HOME/.pytools
	$$HOME/.pytools/bin/pip3 install -r .pytools-packages

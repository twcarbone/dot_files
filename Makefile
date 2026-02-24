.PHONY: install
install: dotfiles pytools


.PHONY: dotfiles
dotfiles:
	rm -f $$HOME/.emacs
	rm -f $$HOME/.bashrc
	rm -f $$HOME/.tidyrc
	rm -f $$HOME/.inputrc
	rm -f $$HOME/.gitconfig
	rm -f $$HOME/.tmux.conf
	rm -f $$HOME/.clang-format
	ln -s $$PWD/.emacs $$HOME/.emacs
	ln -s $$PWD/.bashrc $$HOME/.bashrc
	ln -s $$PWD/.tidyrc $$HOME/.tidyrc
	ln -s $$PWD/.inputrc $$HOME/.inputrc
	ln -s $$PWD/.gitconfig $$HOME/.gitconfig
	ln -s $$PWD/.tmux.conf $$HOME/.tmux.conf
	ln -s $$PWD/.clang-format $$HOME/.clang-format


.PHONY: pytools

PYTHON_CMD          = python3.11
PYTHON_TOOLS_DIR    = $$HOME/.pytools
PYTHON_PIP3_CMD     = $(PYTHON_TOOLS_DIR)/bin/pip3

pytools:
	rm -rf $(PYTHON_TOOLS_DIR)
	$(PYTHON_CMD) -m venv $(PYTHON_TOOLS_DIR)
	$(PYTHON_PIP3_CMD) install -r .pytools-packages

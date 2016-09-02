CUR_DIR:=$(shell pwd)

.PHONY: zsh git tmux

all: zsh git awesome tmux vim ~/.editorconfig ~/.Xdefaults

zsh: ~/.zprezto ~/.zshrc ~/.zpreztorc

git: ~/.gitignore ~/.gitconfig

tmux: ~/.tmux.conf

vim: ~/.vim/ ~/.vimrc
python: ~/.pythonstartup.py

awesome: ~/.config/awesome/ ~/.config/awesome/rc.lua ~/.config/awesome/wp_random.lua


### ZSH ##
~/.zprezto:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	pushd $(CUR_DIR)/prezto; git submodule init; git submodule update; popd
	ln -s $(CUR_DIR)/prezto ~/.zprezto


~/.zshrc:
	ln -s $(CUR_DIR)/zsh/zshrc ~/.zshrc

~/.zpreztorc:
	ln -s $(CUR_DIR)/zsh/zpreztorc ~/.zpreztorc
###########


### GIT ##
~/.gitignore:
	ln -s $(CUR_DIR)/git/gitignore ~/.gitignore

~/.gitconfig:
	ln -s $(CUR_DIR)/git/gitconfig ~/.gitconfig
###########

~/.editorconfig:
	ln -s $(CUR_DIR)/editorconfig ~/.editorconfig

~/.tmux.conf:
	ln -s $(CUR_DIR)/tmux.conf ~/.tmux.conf

~/.Xdefaults:
	ln -s $(CUR_DIR)/X/Xdefaults ~/.Xdefaults


### awesomewm ###
~/.config/awesome/:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	mkdir -p ~/.config/
	pushd $(CUR_DIR)/awesome-copycats; git submodule init; git submodule update; popd
	ln -s $(CUR_DIR)/awesome-copycats ~/.config/awesome
~/.config/awesome/rc.lua:
	ln -s $(CUR_DIR)/awesome/rc.lua ~/.config/awesome/rc.lua
~/.config/awesome/wp_random.lua:
	ln -s $(CUR_DIR)/awesome/wp_random.lua ~/.config/awesome/wp_random.lua

##### VIM #####
~/.vim/:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	ln -s $(CUR_DIR)/vim-cfg/vim ~/.vim
	pushd ~/.vim; git submodule update --init --recursive; popd
	pushd ~/.vim/bundle/ycm; python2 install.py; popd

~/.vimrc:
	ln -s $(CUR_DIR)/vim-cfg/vimrc ~/.vimrc
###############

## python
~/pythonstartup.py:
	ln -s $(CUR_DIR)/python/pythonstartup.py ~/.pythonstartup.py


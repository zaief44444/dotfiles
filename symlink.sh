#!/usr/bin/sh

home_dir='~/'
dotfiles_dir='~/dotfiles'

for files in `find $dotfiles_dir -name '.*' -printf '%f\n'` ; do
	ln -sf $dotfiles_dir/$files $home_dir/$files


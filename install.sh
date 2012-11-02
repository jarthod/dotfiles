#!/bin/bash

# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Source: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles

# folders
dir=~/dotfiles
backup=~/dotfiles_old
files="bashrc gitconfig gemrc"

# create dotfiles_old in homedir
mkdir -p $backup

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Linking dotfiles"
for file in $files; do
  mv -f ~/.$file $backup
  ln -s $dir/$file ~/.$file
done

# copy authorized_keys
if [ ! -e ~/.ssh/authorized_keys ]
then
  echo "Copying authorized_keys"
  ln -s $dir/authorized_keys ~/.ssh/authorized_keys
fi

# install rbenv
if [ ! -e ~/.rbenv ]
then
  echo "Installing rbenv"
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
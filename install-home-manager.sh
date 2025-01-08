# File Name: install.sh
# Author: Jerry Arciaga <jerryarciaga11@gmail.com>
# Purpose: Create symlink from home-manager in repository to home-manager in 
# $HOME/.config/home-manager

#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/home-manager"

if [[ -L $CONFIG_DIR ]]; then
  echo "Removing link $CONFIG_DIR..."
  rm $CONFIG_DIR
elif [[ -d $CONFIG_DIR ]]; then
  echo "Removing directory $CONFIG_DIR..."
  rm -rf $CONFIG_DIR
fi

echo "Installing home-manager config $CONFIG_DIR -> $PWD/home-manager"
ln -sf $PWD/home-manager $CONFIG_DIR
echo "Done."

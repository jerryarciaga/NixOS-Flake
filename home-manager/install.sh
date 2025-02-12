# File Name: install.sh
# Author: Jerry Arciaga <jerryarciaga11@gmail.com>
# Purpose: Create symlink linking .nix files from this repository to
# $HOME/.config/home-manager

#!/usr/bin/env bash

HOME_MANAGER=$PWD
CONFIG_DIR="$HOME/.config/home-manager"
CONFIG_FILES=`ls $HOME_MANAGER/*.nix`

# Start from scratch if there is home manager installed
if [[ -L $CONFIG_DIR ]]; then
  echo "Removing link $CONFIG_DIR..."
  rm $CONFIG_DIR
elif [[ -d $CONFIG_DIR ]]; then
  echo "Removing directory $CONFIG_DIR..."
  rm -rf $CONFIG_DIR
fi

ln -sf $HOME_MANAGER $CONFIG_DIR

# File Name: install.sh
# Author: Jerry Arciaga <jerryarciaga11@gmail.com>
# Purpose: Create symlink linking .nix files from this repository to
# $HOME/.config/home-manager

#!/usr/bin/env bash

HOME_MANAGER=$PWD
CONFIG_DIR="$HOME/.config/home-manager"
CONFIG_FILES=`ls $HOME_MANAGER/*.nix`

# Start from scratch
if [[ -a $CONFIG_DIR/flake.lock ]]; then
  rm $CONFIG_DIR/*.nix
elif [[ -L $CONFIG_DIR ]]; then
  echo "Removing link $CONFIG_DIR..."
  rm $CONFIG_DIR
  mkdir $CONFIG_DIR
elif [[ -d $CONFIG_DIR ]]; then
  echo "Removing directory $CONFIG_DIR..."
  rm -rf $CONFIG_DIR
  mkdir $CONFIG_DIR
elif [[ ! -d $CONFIG_DIR ]]; then
  echo "Creating directory $CONFIG_DIR..."
  mkdir $CONFIG_DIR
fi

# Create/recreate links to editor
for config_file in $CONFIG_FILES; do
  ln -sf $config_file $CONFIG_DIR/.
  echo "Link to $config_file"
done

# Relink modules
if [[ -d $CONFIG_DIR/modules ]]; then
  echo "Removing directory $CONFIG_DIR/modules..."
  rm -rf $CONFIG_DIR/modules
elif [[ -a $CONFIG_DIR/modules ]]; then
  rm $CONFIG_DIR/modules
  echo "Removing file/link $CONFIG_DIR/modules..."
fi

echo "Creating link $HOME_MANAGER/modules -> $CONFIG_DIR/modules..."
ln -sf $HOME_MANAGER/modules $CONFIG_DIR/modules

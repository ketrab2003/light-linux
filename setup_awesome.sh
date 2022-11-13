#!/bin/sh
# This script requires env variables set in setup_all.sh

# create link to awesome config
mkdir -p /home/${SETUP_USERNAME}/.config/
rm -rf /home/${SETUP_USERNAME}/.config/awesome
ln -s "$(pwd)/dotfiles/.config/awesome" "/home/${SETUP_USERNAME}/.config/"

# create link to .xinitrc
rm -rf /home/${SETUP_USERNAME}/.xinitrc
ln -s "$(pwd)/dotfiles/.xinitrc" "/home/${SETUP_USERNAME}/"

# create link to .bash_profile
rm -rf /home/${SETUP_USERNAME}/.bash_profile
ln -s "$(pwd)/dotfiles/.bash_profile" "/home/${SETUP_USERNAME}/"
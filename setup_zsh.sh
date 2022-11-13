#!/bin/sh
# This script requires env variables set in setup_all.sh

# install oh-my-zsh (from https://ohmyz.sh/)
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh-autosuggestions (from https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# create link to .zshrc
rm -rf /home/${SETUP_USERNAME}/.zshrc
ln -s "$(pwd)/dotfiles/.zshrc" "/home/${SETUP_USERNAME}/"

# change default shell
chsh -s "/usr/bin/zsh" "$SETUP_USERNAME"

echo "Done setting up zsh!"
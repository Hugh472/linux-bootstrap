#!/usr/local/env bash

# TODO: Turn this into Ansible

sudo pacman -Syu

yay -Syu

# If macbook pro 2013, if not comment out the following file
yay -S nvidia-470xx-dkms nvidia-470xx-utils lib32-nvidia-470xx-utils opencl-nvidia-470x

#If not
# sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils

# Debugging tools and Steam
sudo pamcan -S vulkaninfo nvidia-settings steam

read -p "Can reboot here to test if Steam games will work.  If you want to continue instead, Press enter"

# install dev tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo pacman -S nerd-fonts starship
yay -S wezterm vscodium zed-preview-editor


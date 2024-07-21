#!/usr/local/env bash

sudo pacman -Syu --noconfirm

yay --noconfirm --answerdiff None --answerclean None --mflags "--noconfirm" -Syu

# If macbook pro 2013, if not comment out the following 
# yay  --answerdiff None --answerclean None --mflags "--noconfirm" -S nvidia-470xx-dkms nvidia-470xx-utils lib32-nvidia-470xx-utils opencl-nvidia-470x

#If not
sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils

# TODO: Firefox add-ons automation if possible

# Thunderbird, calibre, ardour, inkscape, blender
sudo pacman -S --noconfirm thunderbird calibre ardour inkscape blender

# OnlyOffice
yay  --noconfirm --answerdiff None --answerclean None --mflags "--noconfirm" -S onlyoffice-bin

# Debugging tools and Steam
sudo pamcan -S --noconfirm vulkaninfo nvidia-settings steam

read -p "Can reboot here to test if Steam games will work.  If you want to continue instead, Press enter"

# install dev tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo pacman -S --noconfirm nerd-fonts starship
yay --noconfirm --answerdiff None --answerclean None --mflags "--noconfirm" -S wezterm vscodium zed-preview-editor


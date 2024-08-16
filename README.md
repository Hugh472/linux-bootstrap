# linux-bootstrap

This should support GNOME or KDE, but there may be some more tweaks necessary.

When complete, this repo will generate a complete setup for a user to browse the web, email, write documents, read e-books, develop software, make music and digital art, or play AAA video games.


## Usage

curl -s https://raw.githubusercontent.com/Hugh472/linux-bootstrap/main/setup.sh | bash

or

wget -qO- https://raw.githubusercontent.com/Hugh472/linux-bootstrap/main/setup.sh | bash


## Roles (WIP)
1. common - basic updates and configs
3. storage - add all drives to fstab and mount
4. gpu - install AMD or NVIDIA drivers properly for gaming
5. flatpak - install apps for daily driving
6. zsh - install zsh, starship and zsh-autosuggestions
7. git - set up git configs 
8. dev_tools - IDE, languages
9. k8s_tools - docker, kubectl, helm, k3s, k9s
10. torrenting - self-explanatory
11. emulators - run console games on Linux
12. wayland - WIP, ensure complete Wayland support
13. hyprland - WIP, add hyprland for vibes and ease-of-use
14. wakeonlan - WIP, would be nice for a tower

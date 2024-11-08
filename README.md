# linux-bootstrap

This should support GNOME or KDE, but there may be some more tweaks necessary.

When complete, this repo will generate a complete setup for a user to browse the web, email, write documents, read e-books, develop software, make music and digital art, or play AAA video games.


## Usage

curl -s https://raw.githubusercontent.com/Hugh472/linux-bootstrap/main/bootstrap.sh | bash

or

wget -qO- https://raw.githubusercontent.com/Hugh472/linux-bootstrap/main/bootstrap.sh | bash


## Roles (WIP)
1. common - basic updates and configs
3. storage - add all drives to fstab and mount
4. networking - add Tailscale and Proton VPNs
5. gpu - install AMD or NVIDIA drivers properly for gaming/AI
6. flatpak - install apps for daily driving
7. zsh - install zsh, starship and zsh-autosuggestions
8. git - set up git configs 
9. dev_tools - IDE, languages
10. k8s_tools - docker, kubectl, helm, k3s, k9s
11. torrenting - self-explanatory
12. emulators - run console games on Linux
13. wayland - WIP, ensure complete Wayland support
14. hyprland - WIP, add hyprland for vibes and ease-of-use
15. wakeonlan - WIP, would be nice for a tower

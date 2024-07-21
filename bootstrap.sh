#!/bin/bash

# Install necessary dependencies
if [ -f /etc/debian_version ]; then
    sudo apt update
    sudo apt install -y git ansible
elif [ -f /etc/fedora-release ]; then
    sudo dnf install -y git ansible
elif [ -f /etc/arch-release ]; then
    sudo pacman -Syu --noconfirm git ansible
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# Clone the repository
git clone https://github.com/Hugh472/linux-bootstrap.git
cd linux-bootstrap

# Run the Ansible playbook
ansible-playbook -i "localhost," -c local playbook.yml

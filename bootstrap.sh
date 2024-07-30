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
# Define the repository URL and the directory to clone into
REPO_URL="https://github.com/Hugh472/linux-bootstrap.git"
CLONE_DIR="linux-bootstrap"
cd /home/Documents
# Check if the directory exists
if [ -d "$CLONE_DIR" ]; then
    echo "Directory $CLONE_DIR already exists. Skipping clone."
else
    echo "Directory $CLONE_DIR does not exist. Cloning repository."
    git clone "$REPO_URL" "$CLONE_DIR"
fi

# Define the target directory
TARGET_DIR="linux-bootstrap"

# Get the absolute path of the target directory
ABS_TARGET_DIR=$(realpath "$TARGET_DIR")

# Get the current working directory
CURRENT_DIR=$(pwd)

# Compare the current directory with the target directory
if [ "$CURRENT_DIR" != "$ABS_TARGET_DIR" ]; then
    echo "Not in the target directory. Changing directory to $TARGET_DIR."
    cd "$TARGET_DIR" || { echo "Failed to change directory to $TARGET_DIR."; exit 1; }
else
    echo "Already in the target directory $TARGET_DIR."
fi

pwd

ls -la

# Run the Ansible playbook
ansible-playbook -c local setup.yml

#!/usr/local/env bash

# Install necessary dependencies
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y git ansible
elif [[ "$(command -v dnf)" ]]; then
    sudo dnf install -y git ansible
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
elif [[ "$(command -v pacman)" ]]; then
    sudo pacman -Syu --noconfirm git ansible
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# Clone the repository
# Define the repository URL and the directory to clone into
REPO_URL="https://github.com/Hugh472/linux-bootstrap.git"
REPO_NAME="linux-bootstrap"
REPO_DIR="$HOME/Documents/$REPO_NAME"


# Check if the repo is cloned somewhere under the home directory
cd /
existing_repo_dir=$(find "$HOME" -type d -path "*/$REPO_NAME/.git" -print -quit)
echo "existing_repo_dir: $existing_repo_dir"
if [[ -n "$existing_repo_dir" ]]; then
    echo "Repository found at $existing_repo_dir"
    REPO_DIR="$(dirname $existing_repo_dir)"
else
    echo "No existing repository found under the home directory."
fi

# Clone or update the repository
if [[ -d "$REPO_DIR/.git" ]]; then
    echo "Repository already exists. Pulling the latest changes..."
    cd $REPO_DIR
    git pull origin main
else
    echo "Cloning the repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Navigate to the repo directory
cd "$REPO_DIR" || exit

# Confirm latest changes
pwd
ls -al
git status

echo "Repository is up to date."


# Prompt the user for the GitHub token
read -sp 'Enter your GitHub token: ' GITHUB_TOKEN
echo

# Prompt the user for the GitHub username
read -p 'Enter your GitHub username: ' GITHUB_USERNAME

# Prompt the user for the GitHub email
read -p 'Enter your GitHub email: ' GITHUB_EMAIL

# Export the token as an environment variable
export GITHUB_TOKEN

# Run the Ansible playbook with extra variables
ansible-playbook -c local setup.yml --extra-vars "github_user=${GITHUB_USERNAME} github_email=${GITHUB_EMAIL}"

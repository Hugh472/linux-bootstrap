#!/usr/local/env bash

# Define Functions
check_and_update() {
    local key=$1
    local current_value=$(git config --global --get "$key")
    echo "Current $key: $current_value"
    read -p "Is this correct? (y/n): " response
    if [[ $response =~ ^[Nn]$ ]]; then
        read -p "Enter new value for $key: " new_value
        git config --global "$key" "$new_value"
        echo "$key updated to: $(git config --global --get "$key")"
    fi
    echo
}

check_gh_token() {
    if command -v gh &> /dev/null; then
        echo "Checking GitHub CLI token..."
        if gh auth status &> /dev/null; then
            echo "GitHub CLI is authenticated."
            gh auth status
        else
            echo "GitHub CLI is not authenticated."
            read -p "Would you like to authenticate now? (y/n): " response
            if [[ $response =~ ^[Yy]$ ]]; then
                gh auth login
            fi
        fi
    else
        echo "GitHub CLI (gh) is not yet installed."
    fi
}


# Install necessary dependencies
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git ansible
elif [[ "$(command -v dnf)" ]]; then
    sudo dnf upgrade -y
    sudo dnf install -y git ansible
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf upgrade -y
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


# # Check if the repo is cloned somewhere under the home directory
# cd /
# existing_repo_dir=$(find "$HOME" -type d -path "*/$REPO_NAME/.git" -print -quit)
# echo "existing_repo_dir: $existing_repo_dir"
# if [[ -n "$existing_repo_dir" ]]; then
#     echo "Repository found at $existing_repo_dir"
#     REPO_DIR="$(dirname $existing_repo_dir)"
# else
#     echo "No existing repository found under the home directory."
# fi

# # Clone or update the repository
# if [[ -d "$REPO_DIR/.git" ]]; then
#     echo "Repository already exists. Pulling the latest changes..."
#     cd $REPO_DIR
#     git pull origin main
# else
#     echo "Cloning the repository..."
#     git clone "$REPO_URL" "$REPO_DIR"
# fi

# Navigate to the repo directory
cd "$REPO_DIR" || exit 1

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

read -p 'Does your Graphics card requires the Kepler-Series NVIDIA drivers? (y/n) ' KEPLER_ANSWER

if [[ $KEPLER_ANSWER == 'y' || $KEPLER_ANSWER == 'Y' ]];then
  KEPLER=true
elif [[ $KEPLER_ANSWER == 'n' || $KEPLER_ANSWER == 'N' ]];then 
  KEPLER=false
else
 echo "invalid response.  try again"
 exit 1
fi

# Run the Ansible playbook with extra variables
# ansible-playbook -c local setup.yml --extra-vars "github_user=${GITHUB_USERNAME} github_email=${GITHUB_EMAIL} kepler=${KEPLER}"
ansible-playbook -c local setup.yml --extra-vars "kepler=${KEPLER}"

# refresh groups so docker works immediately
sudo su $USER

# tailscale auth
tailscale up

echo "you will want to delete this repo and re-clone it via ssh"
echo "you will also want to reboot so GPU changes take place"
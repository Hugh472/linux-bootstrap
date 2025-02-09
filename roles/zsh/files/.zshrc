# ~/.zshrc

# Enable starship prompt
eval "$(starship init zsh)"

# Enable zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

eval $(ssh-agent)
ssh-add "~/.ssh/id_rsa"

# Enable other zsh plugins or configurations

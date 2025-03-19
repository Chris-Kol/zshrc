# =============================================================================
# OH-MY-ZSH CONFIGURATION
# =============================================================================

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugin configuration - carefully select to avoid slowdown
plugins=(git jump history zsh-autosuggestions zsh-syntax-highlighting)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# =============================================================================
# BASIC ALIASES
# =============================================================================

# Development tools
alias python="python3"
alias storm="open -na "PhpStorm.app" --args "$@""

# Navigation
alias j="jump"
alias preview="fzf --preview 'bat --style=\"numbers\" --line-range :500 --color \"always\" {}'"

# PHP Quality tools
alias psalm="./vendor/bin/psalm -c psalm.ci.xml --php-version=8.0 --disable-extension=xdebug --threads=8"
alias stan="composer phpstan-ci"
alias phpcs="composer phpcs-ci"

# NPM shortcuts
alias watch="npm run watch"
alias build="npm install && npm run build"

# =============================================================================
# GIT ALIASES
# =============================================================================

# English git aliases
alias gs="git status"
alias gc="git commit -m"
alias gp="git fetch --all && git pull"
alias gco="git checkout"
alias sts="git stash"
alias unstage="git restore --staged ."

alias γσ="git status"
alias γψ="git commit -m"
alias γπ="git fetch --all && git pull"
alias γψο="git checkout"

# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# Copy SSH public key to clipboard for easy sharing
function sshkey() {
    local public_key_file="$HOME/.ssh/id_rsa.pub"

    if [[ ! -f "$public_key_file" ]]; then
    echo "Public SSH key file not found."
    return 1
    fi

    echo "Copying public SSH key to clipboard..."
    pbcopy < "$public_key_file"
    echo "Public SSH key copied to clipboard."
}

# Edit .zshrc file with VS Code
function editzshrc() {
    code ~/.zshrc
}

# Reload .zshrc after changes
function sourcezsh() {
    source ~/.zshrc
}

# Apply a specific stash (defaults to the most recent one)
function pop() {
    local stash_index=${1:-0}
    git stash pop stash@{$stash_index}
}

# Navigate up multiple directory levels at once
# Usage: up 3 (goes up 3 directories)
up() {
   cd $(printf "../%.0s" $(seq 1 $1))
}

# Create directory and navigate into it in one command
# Usage: mkcd new_directory
mkcd() {
   mkdir -p "$1" && cd "$1"
}

# Clean up git branches that no longer exist on the remote
# Use -f or --force to force delete branches
function gitclean() {
    local delete_command="-d"
    for arg in "$@"; do
        if [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
            delete_command="-D"
        fi
    done
    git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs -r git branch $delete_command
}

# =============================================================================
# KEYBINDINGS
# =============================================================================

# Accept autosuggestion with double tab
bindkey '\t\t' autosuggest-accept

# =============================================================================
# EXTERNAL TOOLS & PATH CONFIGURATION
# =============================================================================

# Load fuzzy finder
source <(fzf --zsh)

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
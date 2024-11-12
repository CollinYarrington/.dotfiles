# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	artisan
	npm
	composer
	ionic
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# =============== #
# Collin's Config #
# =============== #

alias zr='omz reload'
# Laravel Sail Shortcuts:
alias a='sail artisan'
alias ls='ls -a'
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"

# git alias
alias gch='git checkout'
alias gcom='git commit -m'
alias gpush='git push'
alias gpull='git pull'

# docker alias
alias dworkspace='docker-compose exec workspace bash'
binto(){
	
	local target_dir="$HOME/projects/laradock8.2"
	echo "Navigating to $target_dir"
	cd "$target_dir" || { echo "Failed to navigate to $target_dir"; return 1; }
	echo "\n *========================# Active Docker Containers #========================* \n"
	
	containers=($(docker ps --format "{{.Names}}"))
	# Check if there are any active containers
    if [[ ${#containers[@]} -eq 0 ]]; then
		echo "\n 		          No active containers found \n"
		echo "\n *========================# Active Docker Containers #========================* \n\n"
		return
    fi

	local index=1
	# Display the indexed list of containers
	for container_name in "${containers[@]}"; do
		echo "[$index]  ${container_name}"
		((index++))
	done
	
	echo "\n *========================# Active Docker Containers #========================* \n\n"
    echo "Please enter the number of the container you want to access (or type 'exit', 'close', or 'bye' to quit):"
   	read selection
	selection_lower="${selection:l}"

	if [[ "$selection_lower" == "exit" || "$selection_lower" == "close" || "$selection_lower" == "bye" ]]; then
		echo "Goodbye 👋"
	elif [[ "$selection" =~ ^[0-9]+$ ]] && (( selection > 0 && selection <= ${#containers[@]} )); then
        container_name="${containers[selection]}"
		echo "You have selected $container_name"
        docker exec -it $container_name bash
	else
		echo "Something went wrong ❌"
	fi
}

editzsh(){
	local target_dir="$HOME/.dotfiles/.zshrc"
	if [[ -n "$1" ]]; then
		echo "Attempting to load provided editor"
		$1 $target_dir
	else
		vim $target_dir
	fi

	return 1
}



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

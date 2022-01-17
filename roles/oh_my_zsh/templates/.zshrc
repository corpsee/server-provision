# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nameless"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/bin:$HOME/Bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM='xterm-256color'

alias zsh_config_reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zsh_reload="exec zsh && echo 'ZSH reloaded'"

alias normal_mode="chmod -R u-x,go-x-w,u=rwX,go=rX"
alias personal_mode="chmod -R u-x,go-r-w-x,u=rwX,go="

alias find_file="find . -type f -name"
alias find_directory="find . -type d -name"

alias ctrlc="xclip -selection clipboard -i"
alias ctrlv="xclip -selection clipboard -o"

alias clean_system="sudo aptitude autoclean && sudo aptitude clean && sudo apt-get autoremove"
alias add_ppa='sudo add-apt-repository'

alias system_size="df --human-readable --total --print-type"
alias one_dir_size="du --human-readable --summarize --time"
alias dir_size="du --human-readable --max-depth=1 --time --total"
alias dir_size_all="du --human-readable --max-depth=1 --all --time --total"

alias generate_password="openssl rand --base64"

alias show_listen="sudo netstat -tulpan | grep LISTEN"

alias composer_5.6="php5.6 /usr/local/bin/composer"
alias composer_7.0="php7.0 /usr/local/bin/composer"
alias composer_7.1="php7.1 /usr/local/bin/composer"
alias composer_7.2="php7.2 /usr/local/bin/composer"
alias composer_7.3="php7.3 /usr/local/bin/composer"
alias composer_7.4="php7.4 /usr/local/bin/composer"
alias composer_8.0="php8.0 /usr/local/bin/composer"
alias composer_8.1="php8.1 /usr/local/bin/composer"

alias restart_pulseaudio="killall -9 pulseaudio"

function generate_ssh() {
    if [[ $# -eq 0 ]]; then
        ssh-keygen -o -t rsa -b 4096 -C "poisoncorpsee@gmail.com" -P "";
    else
        ssh-keygen -o -t rsa -b 4096 -C "poisoncorpsee@gmail.com" -P "" -f "$1";
    fi;
}

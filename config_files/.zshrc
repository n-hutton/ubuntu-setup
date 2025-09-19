# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/nhutton/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
#POWERLEVEL9K_DISABLE_RPROMPT=true

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs dir load ram vcs ssh command_execution_time)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Force writing to the bash history on every prompt
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Set a proj variable for project base
proj=~/repos/backend
alt=~/repos/ledger-api-py

export proj
alias pro='cd `git rev-parse --show-toplevel || echo $proj`'
alias alt='cd $alt'
alias checkall='cargo +nightly fmt;cargo clippy --fix --lib -p zilliqa --allow-dirty;cargo +nightly fmt && cargo build --all-targets --all-features && __CARGO_FIX_YOLO=1 cargo clippy --allow-dirty --allow-staged --all-targets --all-features --fix && cargo clippy --all-targets --all-features -- -D warnings && echo "TESTING" &&  cargo test --release --all-targets --all-features'

alias up='echo `git rev-parse --show-toplevel`; cd `git rev-parse --show-toplevel`'

alias v='vim -p'
alias gi='git'

alias k='kubectl'

function print_job_counts() {

# running jobs:
bg_jobs_cur_r=`jobs -r | wc -l 2> /dev/null | xargs` ;
# stopped jobs
bg_jobs_cur_s=`jobs -s | wc -l 2> /dev/null | xargs` ;

# Only print if there are jobs.
if [ 0 -ne $bg_jobs_cur_r ] || [ 0 -ne $bg_jobs_cur_s ] ; then
  #echo "[${bg_jobs_cur_s} ]" ;
  echo "[${bg_jobs_cur_s} ${bg_jobs_cur_r}]" ;
fi
}

# Overload cd 
cd(){
    if [[ -f "$@" ]]
    then
        DIR=$(dirname "$@")
        echo -e "\e[31mChanging to: $DIR\e[0m "
        builtin cd "$DIR"
    else
        builtin cd "$@"
    fi
}

rr(){
    rg -i "$*"
}

rl(){
    rg -il "$*"
}

alias openall='eval $(history | grep -E "[0-9]+  rr " | tail -n 1 | sed -En "s/.*  rr (.*)/v $\(rl \1\)/p")'

alias dc='docker-compose'
alias gi='git'

alias grep='ggrep'
alias find='gfind'
alias style='./scripts/apply_style.py -c master && git st'
alias styleall='./scripts/apply_style.py && git st'
alias stylecom='./scripts/apply_style.py -c master && git add -u && git commit -m "style"'
alias stylecompush='./scripts/apply_style.py -c master && git add -u && git commit -m "style && git push --set-upstream nathan"'
alias empty='git commit --allow-empty -m "Empty commit"'

# Keep 1,000,000 lines of history within the shell and save it to ~/.zsh_history:
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=2000000
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# All path modifications go here
PATH=$PATH:~/repos/scripts
PATH=$PATH:/Users/nhutton/repos/flutter/bin
PATH=$PATH:/Users/nhutton/Library/Android/sdk/cmdline-tools/latest/bin
PATH=$PATH:/opt/homebrew/bin
PATH=$PATH:/Users/nhutton/repos/vcpkg
PATH=$PATH:/Users/nhutton/repos/scripts

export PATH

export VCPKG_ROOT="/Users/nhutton/repos/vcpkg"
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# Don't question deletion with rm *
setopt rmstarsilent

# Bash like * behaviour
setopt +o nomatch

# Don't share history
setopt no_share_history
unsetopt share_history

export GOPATH=~/go
export GO111MODULE=on

# Turn on pyenv automatically
#eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# https://stackoverflow.com/questions/47691479/listing-all-resources-in-a-namespace
function kgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    
    if [ -z "$1" ]
    then
        kubectl get --ignore-not-found ${i}
    else
        kubectl -n ${1} get --ignore-not-found ${i}
    fi
  done
}

# Created by `pipx` on 2025-03-10 18:40:09
export PATH="$PATH:/Users/nhutton/.local/bin"

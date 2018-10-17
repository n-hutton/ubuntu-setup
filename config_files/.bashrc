# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Force writing to the bash history on every prompt
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ggg='gdb --ex=run--args'

# open changed git files
#alias gitst='git st | grep "^ M" | cut -f 3 -d \' \''

alias lsdir='ls --group-directories-first -lF'

alias doit='sudo apt-get -y install `cat ~/.bash_history | tail -n 1 | sed -e "s/^\(\w\+\).*/\1/"` && cat ~/.bash_history | tail -n 2'

# Fix annoying screen error
alias sc='screen && clear && echo \"Killed screen\"'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

eval `dircolors ~/.dir_colors`
alias ls="ls --color=auto"
#alias ls="ls --color=none"

alias netcat='nc'
#alias v='vim.gnome -p'
alias v='vim -p'
alias ,q='exit'
alias py='python3'

alias ecl='eclipse --launcher.openFile'
alias startecl='if ! pgrep -x "eclipse" > /dev/null; then /home/nathan/Downloads/eclipse-cpp-oxygen-R-linux-gtk-x86_64_binary/eclipse/eclipse 2>&1 & fi'

#alias hibernate='/usr/bin/gnome-screensaver-command --lock && pm-hibernate'
alias term='gnome-terminal --geometry 208x290+0+0;exit;'
alias byme='git log --pretty="%H" --author="XXX" | while read commit_hash;do git show --oneline --name-only $commit_hash | tail -n+2; done | sort | uniq'
alias aaa='date && zenity --error --width=400 --height=200 --text "Job done"'
alias diff='diff -bEBw'
alias newvnc='vncserver -geometry 3350x1040'
alias pss='ps -eo pid,cmd,etime,user'
alias rmvsim='rm vish_stacktrace.vstf vsim.wlf work/ transcript modelsim.ini -rf'

alias jjj='grep -E "^|error"'
# Search for todos

alias alltodos='grep -rnIsT "TODO: (N Hutton)" ./ | sed "s/:/ /" | tee ./alltodos && v ./alltodos'


#alias gitlog='git log --graph --abbrev-commit --decorate --date=relative --format=format:\'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold green)%d%C(reset)\' --all'

alias ssh='TERM=xterm ssh'

if [ $HOSTNAME = "XXX" ]; then
    TERM=xterm-256color
else
    TERM=xterm-256color
fi

#TERM=xterm
alias changeterm='export TERM=xterm'

#if you want to find out what the colors do
#eval $(echo "no:global default;fi:normal file;di:directory;ln:symbolic link;pi:named pipe;so:socket;do:door;bd:block device;cd:character device;or:orphan symlink;mi:missing file;su:set uid;sg:set gid;tw:sticky other writable;ow:other writable;st:sticky;ex:executable;"|sed -e 's/:/="/g; s/\;/"\n/g')           
#{      
#    IFS=:     
#    for i in $LS_COLORS     
#    do        
#        echo -e "\e[${i#*=}m$( x=${i%=*}; [ "${!x}" ] && echo "${!x}" || echo "$x" )\e[m" 
#    done       
#} 

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

shopt -s globstar

function set-title() {
    if [[ -z "$ORIG" ]]; then
        ORIG=$PS1
    fi
    TITLE="\[\e]2;$@\a\]"
    PS1=${ORIG}${TITLE}
}

## Prints counters for jobs: (<running>, <stopped>), or nothing if there are none
function print_job_counts() {

# running jobs:
bg_jobs_cur_r=`jobs -r | wc -l 2> /dev/null` ;
# stopped jobs
bg_jobs_cur_s=`jobs -s | wc -l 2> /dev/null` ;

# Only print if there are jobs.
if [ 0 -ne $bg_jobs_cur_r ] || [ 0 -ne $bg_jobs_cur_s ] ; then
  #echo "[${bg_jobs_cur_s} ]" ;
  echo "[${bg_jobs_cur_s} ${bg_jobs_cur_r}]" ;
fi
}

parse_git_branch() {
     # Old - just your branch name
     #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     git branch -vv 2> /dev/null | sed -e '/^[^*]/d' -e 's/.*\[\(.*\)\].*/ (\1)/'
}

# Command line prompt:
export PS1='\[\e[0;34m\]\u@\h \[\e[0;34m\]\[\e[0;32m\]\w\[\e[0m\]$(parse_git_branch)\[\e[0;33m\]\n`if [ "$mybash" = "mybash" ]; then print_job_counts; fi` $ \[\e[0m\]'

mybash=mybash
export mybash

#######################################################################################
# Finding functions

# Set a proj variable for project base
proj=~/repos/fetch-ledger
export proj
alias pro='cd $proj'

setproj(){
    tempvar=`pwd`
    echo "Setting proj to $tempvar"
    proj="$tempvar"
    export proj
}


###############
# Grep/find

vgrep(){
    #echo "grep -rnIsT \"$@\" --include=*.vhd" ./
    grep -rnIsT "$@" --include=*.vhd
}

sgrep(){
    grep -rnIsT "$@" --include=*.sh
}

ffind(){
    find -name $@
}

igrep(){
    grep -rnIsTi "$*" ./
}

cgrep(){
    grep -rnIsTi "$*" --include=*.cpp --include=*.h --include=*.c --include=*.cc --include=*.hpp ./
}

cgrepl(){
    grep -rnIsTi "$*" --include=*.cpp --include=*.h --include=*.cc --include=*.hpp -l ./
}

pgrep(){
    grep -rnIsTi "$*" --include=*.py ./
}

pgrepl(){
    grep -rnIsTi "$*" --include=*.py -l ./
}

alias todogrep='grep -rnIsT "TODO: (\`HUT\`)"'

alias gg='set -f;raw_gg';raw_gg(){ command raw_gg "$@";set +f;}

raw_gg(){
    for last;do true;done
    first=$1
    #echo "last was $last"
    length=$(($#-1))
    echo "length is $length"
    if [ -d "$last" ]; then
        echo "last: \"$last\" is a valid path"
        echo -e "\e[31mGrepping -rnI, \"${@:1:$length}\" $last ignore .git/ \e[0m "
        searchstring=${@:1:$length}
        grep -rnI $searchstring $last
        echo "$searchstring"
        grep -rnI "pri" ./
    elif [ -d "$first" ]; then
        echo "first: \"$first\" is a valid path"
        echo -e "\e[31mGrepping -rnI, \"${@:2:$length}\" $first ignore git dirs \e[0m "
        grep -rnI \"${@:2:$length}\" $first
    else
        echo "\"$last\" is not a valid path"
        echo -e "\e[31mGrepping -rnI, \"$@\" ./ ignore .git/ dependencies/ \e[0m "
        grep -rnI "$@" ./
    fi
    #grep -rnI --exclude-dir=.git

}

# grep in proj
gp(){
    echo -e "\e[31mGrepping for \"$1\" in $proj for .vhd .src .tcl .xdc .c* .h Make \e[0m "
    #echo "Arg is $1"
    grep -rnI "$*" $proj --include=*.vhd --include=*.tcl --include=*.src --include=*.xdc --include=*.c --include=*.cc --include=*.h --include=Make* --include=*.mk
}

m(){
    last=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
    echo -e "\e[31mLast command is \"$last\"\e[0m"
    $last
}

ma(){
    echo -e "\e[31mMaking...\e[0m "
    #make $1 2>&1 | grep -Ei --color "^|error"
    #make $1 2>&1 | GREP_COLORS='mt=0;31' grep -Ei --color "^|warn|error"

    time make $* 2>&1 \
    | tee /tmp/terminal_output \
    |  sed -e "s/error/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/ERROR/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/Error/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/undefined reference/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/.*Timing score.*/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/.*not met.*/\x1b[1;37;41m&\x1b[0m/" \
                             -e "s/warn\|warning/\x1b[1;31m&\x1b[0m/" \
                             -e "s/.*success.*/\x1b[1;37m&\x1b[0m/" \
                             -e "s/.*All constraints.*/\x1b[1;37m&\x1b[0m/"           | head -n 40
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

#find in proj
#alias fp='echo -e "\e[31mFinding \"$1\" in $proj \e[0m ";find $proj -name'
fp(){
    echo -e "\e[31mFinding \"*$@*\" in $proj \e[0m "
    #echo "Arg is $1"
    echo "find $proj -type f -not \( -path ./platform* -o -path ./packages* -o -path *dependencies* -o -path *.git* \) -prune -name \"*$@*\" | sed -e \"s/$@/\x1b[1;31m&\x1b[0m/\""
    find $proj -type f -not \( -path ./platform* -o -path ./packages* -o -path *dependencies* -o -path *.git* \) -prune -name "*$@*" | sed -e "s/$@/\x1b[1;31m&\x1b[0m/"
}

fh(){
    echo -e "\e[31mFinding \"$@\" in current directory \e[0m "
    #echo "Arg is $1"
    find ./ -name "*$@*" | sed -e "s/$@/\x1b[1;31m&\x1b[0m/"
}

#change to proj
alias ccp='cd $proj'
alias amke='make'

# use xclip to pipe to clipboard if possible
alias clip='xclip -selection clipboard'

alias op='set -f;raw_op'
alias oo='set -f;raw_oo'

# Lets do our vim wrapper
# Behaviour: op regex* recursively finds these files and opens them
raw_op(){
    set +f
    cmd_one $@
}

cmd_one(){
    # Search and replace spaces with asterisks
    var=$@
    #echo "Var is $var"
    var="${var// /*}"
    #echo "Var is $var"
    echo -e "\e[31m find $proj -type f -not \( -path ./platform* -o -path ./packages* -o -path *dependencies* -o -path *.git* \) -prune -name \"*$var*\"  \e[0m"
    find $proj -type f -not \( -path ./platform* -o -path ./packages* -o -path ./dependencies* -o -path *.git* \) -prune -name "*$var*"
    /XXX/vim74/src/vim -p $(find $proj -type f -not \( -path ./platform* -o -path ./packages* -o -path ./dependencies* -o -path *.git* \) -prune -name "*$var*")
}

raw_oo(){
    set +f
    cmd_two $@
}

cmd_two(){
    echo -e "\e[31m find ./ -type f -not \( -path ./platform* -o -path ./packages* -o -path *dependencies* -o -path *.git* \) -prune -name \"*$@*\"  \e[0m"
    find ./ -type f -not \( -path ./platform* -o -path ./packages* -o -path ./dependencies* -o -path *.git* \) -prune -name "*$@*"
    /XXX/vim74/src/vim -p $(find ./ -type f -not \( -path ./platform* -o -path ./packages* -o -path ./dependencies* -o -path *.git* \) -prune -name "*$@*")
}

# Clipboard mods

PATH=$PATH:~/workflow/xclip-master
export PATH

# add
PATH=$PATH:~/repos/scripts
export PATH


#cl(){
#    echo -e "\e[31m Copying selection to clipboard \e[0m"
#    $(!!) | ~/workflow/xclip-master/xclip -i -selection clipboard
#}


#This bash function will block until the given file appears or a given timeout is reached. The exit status will be 0 if the file exists;
#if it doesn't, the exit status will reflect how many seconds the function has waited.

wait_file() {
  local file="$1"; shift
  local wait_seconds="${1:-10}"; shift # 10 seconds as default timeout

  until test $((wait_seconds--)) -eq 0 -o -f "$file" ; do sleep 1; done

  ((++wait_seconds))
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# directory jumping
function locn() {
         if [ "$1" = "" ]
         then
                whereelse
         else
         t=`whereelse $1`
         cd "$t"
         fi
}

# search and replace in codebase (SO 8611822)
#find ./ -type f -name "*.hpp" "*.cpp" -exec sed -i 's/substitution/replacement/g' {} \;


export CXX=/usr/bin/clang++-6.0 
export CC=/usr/bin/clang-6.0
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

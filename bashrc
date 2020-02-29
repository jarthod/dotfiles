# rbenv shell integration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="./bin:~/.dotfiles/bin:$PATH"

# If not running interactively, stop here
[ -z "$PS1" ] && return

# Disable PATH caching (usefull for ./bin)
set +h

# Redirect to home if not allowed in this folder
if [ ! -w "$PWD" ]; then cd $HOME; fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# git prompt
__git_ps1 ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " (%s)" "${b##refs/heads/}";
    fi
}

# colored prompt
username=`whoami`
case $username in
"root")
    export PS1="\[\e[01;31m\]" # red
    ;;
"deploy")
    export PS1="\[\e[01;35m\]" # purple
    ;;
*)
    export PS1="\[\e[01;32m\]" # green
    ;;
esac

export PS1="$PS1\u@\h \[\e[01;36m\][\W]\[\e[01;35m\]\$(__git_ps1) \[\e[01;33m\]>\[\e[m\] "

# aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias r='touch tmp/restart.txt'
alias be="bundle exec"
alias edit="subl"
alias gs="git status"
alias ga="git add -A"
alias gb="git branch"
alias gd="git diff"
alias gr="git rm"
alias gcm="git commit -m"
alias gp="git pull"
alias gpr="git pull --rebase"
alias gc="git checkout"
alias gl="git log"
alias gb="git blame"
alias gsu="git submodule update --init"
alias ack="ack-grep"
alias grep='grep --color=auto'
alias tcurl='curl -w "\n\nRedir: %{time_redirect}\n  DNS: %{time_namelookup}\n  TCP: %{time_connect}\n  TLS: %{time_appconnect}\nStart: %{time_starttransfer}\n ----------\nTotal: %{time_total}\n"'
alias updn='ssh -t db3 "cd updown/current && bin/rails c -e production"'
alias updn-staging='ssh -t db3 "cd updown-staging/current && bin/rails c -e staging"'

# Dotfiles aliases
alias dotfiles-update="cd ~/.dotfiles && git pull && sh install.sh; cd -"

# default text editor
if command -v subl >/dev/null 2>&1
then
  export EDITOR='subl -w'
else
  export EDITOR='vim'
fi

# exec ruby command as root
function rbenvsudo() {
  executable=$1
  shift 1
  sudo $(rbenv which $executable) $*
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# easily share a file
function upload {
  curl -# -F "file=@$1" https://file.io > /tmp/upload
  local id=`cat /tmp/upload | grep -Eo '"key":"\w{6}"' | grep -Eo "\w{6}"`
  echo "https://file.io/$id"
}

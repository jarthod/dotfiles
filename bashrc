# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
alias be="bundle exec"
alias edit="subl"
alias rspec="bundle exec rspec --format documentation"
alias gs="git status"
alias ga="git add"
alias gr="git rm"
alias gcm="git commit -m"
alias gp="git pull"
alias ack="ack-grep"
alias grep='grep --color=auto'

# SSH aliases
alias lambda="ssh bigbourin@lambda.rootbox.fr"
alias vks="ssh root@vks.rootbox.fr"
alias vps6="ssh deploy@vps6.rootbox.fr"
alias vps5="ssh deploy@vps5.rootbox.fr"
alias pi="ssh deploy@pi.rootbox.fr"
alias raspi="ssh pi@desk.rootbox.fr"
alias mars="ssh -p 2200 adrian@mars.resolve.io"
alias omicron="ssh deploy@omicron.rootbox.fr"

# Dotfiles aliases
alias dotfiles-update="cd ~/dotfiles && git pull && sh install.sh; cd -"

# rbenv shell integration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# default text editor
if command -v subl >/dev/null 2>&1
then
  export EDITOR='subl -w'
else
  export EDITOR='emacs -nw'
fi

# exec ruby command as root
function rbenvsudo() {
  executable=$1
  shift 1
  sudo $(rbenv which $executable) $*
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

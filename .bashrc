# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# Scripts definitions when boot terminal
# You may want to run the script when boot terminal,
# put all your scripts into a separate file like ~/.bash_boot_scripts,
# instead of adding them here directly.

if [ -d ~/.bash_boot_scripts ]; then
    for filename in `ls -a ~/.bash_boot_scripts`; do
        if [ $filename != "." ] && [ $filename != ".." ]; then
            sh ~/.bash_boot_scripts/$filename
        fi
    done
fi

# Alias definitions.
# You may want to put all your additional aliases into a separate file
# like ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -d ~/.bash_aliases ]; then
    for filename in `ls -a ~/.bash_aliases`; do
        if [ $filename != "." ] && [ $filename != ".." ]; then
            . ~/.bash_aliases/$filename
        fi
    done
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# Software configurations.
# You may want to put all your additional software configrations
# into a separate file like ~/.software_configurations,
# instead of adding them here directly.

if [ -d ~/.software_configurations ]; then
    for filename in `ls -a ~/.software_configurations`; do
        if [ $filename != "." ] && [ $filename != ".." ]; then
            . ~/.software_configurations/$filename
        fi
    done
fi

# Supports Japanese
export LANG=ja_JP.UTF-8

PS1='\e[32m\u@\h\e[37m:\e[36m \w\n\e[0m\$ '

export PATH="$PATH:$HOME/.cargo/bin"

#starship
eval "$(starship init bash)"

export DENO_INSTALL="/$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=$PATH:$HOME/.local/kitty.app/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

#java
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64/"
export PATH="$PATH:$JAVA_HOME/bin"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
alias claude="/home/sg3t41/.claude/local/claude"

# SSH鍵の自動読み込み
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_id 2>/dev/null

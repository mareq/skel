# Customized bashrc file.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Based on the .bashrc file from the Debian distribution.
# Last change: 2021 Apr 15


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4096
HISTFILESIZE=65536

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
use_custom_prompt=yes

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

# functions used for displaying running time of the last command
function timer_start {
  TIMER=${TIMER:-$SECONDS}
}

function timer_stop {
  TIMER=$(($SECONDS - $TIMER))

  if [ "${TIMER}" -ge 3600 ]; then
    timer_show=$(printf "%02d:%02d:%02d" $((TIMER/3600)) $((TIMER%3600/60)) $((TIMER%60)))
  elif [ "${TIMER}" -ge 60 ]; then
    timer_show=$(printf "%02d:%02d" $((TIMER/60)) $((TIMER%60)))
  else
    timer_show=$(printf "%02d" $TIMER)
  fi

  unset TIMER
}

trap 'timer_start' DEBUG

if [ "${PROMPT_COMMAND}" == "" ]; then
  PROMPT_COMMAND="timer_stop"
elif [ "${PROMPT_COMMAND}" == "timer_stop" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="${PROMPT_COMMAND}; timer_stop"
fi

# prompt
if [ "$color_prompt" = yes ]; then
  # color codes:
  # 30=black   34=blue
  # 31=red     35=magenta
  # 32=green   36=cyan
  # 33=yellow  37=white
  if [ "${use_custom_prompt}" = "" ]; then
    # original prompt
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  elif [ "$(id -u)" = "0" ]; then
    # custom root prompt
    # single-line
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[32m\]:\[\033[01;33m\]$?\[\033[32m\]:\[\033[01;33m\]${timer_show}\[\033[32m\]:\[\033[01;33m\]\w\[\033[00m\]# '
    # prompt-on-new-line
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\][\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[32m\]:\[\033[01;33m\]$?\[\033[32m\]:\[\033[01;33m\]${timer_show}\[\033[32m\]:\[\033[01;33m\]\w\[\033[34m\]]\[\033[00m\]\n# '
  else
    # custom user prompt
    # single-line
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[31m\]:\[\033[01;33m\]$?\[\033[31m\]:\[\033[01;33m\]${timer_show}\[\033[31m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    # prompt-on-new-line
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\][\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[31m\]:\[\033[01;33m\]$?\[\033[31m\]:\[\033[01;33m\]${timer_show}\[\033[31m\]:\[\033[01;33m\]\w\[\033[31m\]]\[\033[00m\]\n\$ '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt use_custom_prompt

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
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# additional configuration
export SHRC_D="${HOME}/.config/sh/"
for rcfile in $(find ${SHRC_D} -maxdepth 1 -type f -or -type l); do
  source "${rcfile}"
done


# vim: ts=2 sw=2 et



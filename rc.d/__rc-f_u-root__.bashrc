# Customized bashrc file.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Based on the .bashrc file from the Debian distribution.
# Last change: 2021 Apr 15


# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

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
  # single-line
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[32m\]:\[\033[01;33m\]$?\[\033[32m\]:\[\033[01;33m\]${timer_show}\[\033[32m\]:\[\033[01;33m\]\w\[\033[00m\]# '
  # prompt-on-new-line
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\][\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[32m\]:\[\033[01;33m\]$?\[\033[32m\]:\[\033[01;33m\]${timer_show}\[\033[32m\]:\[\033[01;33m\]\w\[\033[34m\]]\[\033[00m\]\n# '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w# '
fi
unset color_prompt force_color_prompt use_custom_prompt

# aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
# these are not in the `.bash_aliases` b/c that file is shared
# with normal users as well and they have shell-independedn
# script with these (so that they get also to ZSH)
alias l='ls -ClF'
alias cd..='cd ..'                              # 1
alias cd...='cd ../..'                          # 2
alias cd....='cd ../../..'                      # 3
alias cd.....='cd ../../../..'                  # 4
alias cd......='cd ../../../../..'              # 5
alias cd.......='cd ../../../../../..'          # 6
alias cd........='cd ../../../../../../..'      # 7
alias cd.........='cd ../../../../../../../..'  # 8
alias dir='vim .'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# vim: ts=2 sw=2 et



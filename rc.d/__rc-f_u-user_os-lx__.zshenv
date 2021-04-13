# ZSH configuration
# Maintainer: Marek Balint <mareq@balint.eu>
# Last change: 2021 Apr 09

# set PATH so that it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so that it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# keep output of less on the screen after quitting 
# https://stackoverflow.com/questions/42021517/is-it-possible-to-keep-the-output-of-less-on-the-screen-after-quitting
#export LESS="Xr"
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-corepager
#export LESS="FRX"


# vim: ts=2 sw=2 et



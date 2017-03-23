# Customized bash_aliases file.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Last change: 2016 Oct 26


export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -l'
alias cgrep='grep --color=always'
alias cd..='cd ..'
alias g11='g++ -std=c++11'



# ZSH configuration
# Maintainer: Marek Balint <mareq@balint.eu>
# Last change: 2021 Apr 12
# 
# To update plugins:
# ```
# $ omz update
# $ zplug update
# ```


# TMUX
# TODO: Consider using `tmux` pluginc with `ZSH_TMUX_AUTOSTART="true"` instead.
# automatically attach/create tmux session if not already inside one...
TMUX_AUTOSTART="${HOME}/.tmux-autostart"
alias tmux-autostart="touch ${TMUX_AUTOSTART}"
alias tmux-noautostart="rm -f ${TMUX_AUTOSTART}"
if [ -f "${TMUX_AUTOSTART}" ]; then
  if command -v tmux > /dev/null 2>&1 && [ -n "$PS1" ] && [ -z "${TMUX}" ]; then
    tmux ls > /dev/null 2>&1
    HAS_TMUX_SESSION=${?}
    if [ "${HAS_TMUX_SESSION}" = "0" ]; then
        exec tmux attach
        echo "DEBUG: tmux attach"
    else
      exec tmux new-session -s default
      echo "DEBUG: tmux new-session -s default"
    fi
    echo "ERROR: Can not attach/create tmux session!"
  fi
fi
# ...set-up ZSH otherwise:

# THEME (early init)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PLUGINS: OH-MY-ZSH
export OHMYZSH_HOME="${HOME}/.local/share/oh-my-zsh/"
plugins=( \
  # vi-mode needs to be set early, so that other plugins do the key-bindings correctly
  vi-mode \
  # shell looks
  colorize \
  colored-man-pages \
  # shell behavior
  dotenv \
  per-directory-history \
  command-not-found \
  gpg-agent \
  # alisases for shell commands
  common-aliases \
  zsh_reload \
  copybuffer \
  copydir \
  copyfile \
  cp \
  genpass \
  ripgrep \
  rsync \
  # tool-specific extensions
  aws \
  cargo \
  docker \
  gcloud \
  git \
  git-extras \
  kubectl \
  minikube \
  node \
  npm \
  nvm \
  pass \
  perl \
  pip \
  python \
  rust \
  rustup \
  # TODO: tmux \
  # TODO: tmuxinator \
  yarn \
)
# make '_' and '-' interchangeable for auto-completion
HYPHEN_INSENSITIVE="true"
# fallback to fix pasting URLs and other test
#DISABLE_MAGIC_FUNCTIONS="true"
# disable colors in ls.
#DISABLE_LS_COLORS="true"
# disable auto-setting terminal title
DISABLE_AUTO_TITLE="true"
# enable command auto-correction
ENABLE_CORRECTION="true"
# Toggle-key for switching b/w global and directory-local history
PER_DIRECTORY_HISTORY_TOGGLE='^G'
# do autosuggestions asynchronously
# https://github.com/zsh-users/zsh-autosuggestions/issues/597
ZSH_AUTOSUGGEST_USE_ASYNC="true"
# display red dots whlist waiting for completion
COMPLETION_WAITING_DOTS="true"
# do not mark untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"
# load plugins
source "${OHMYZSH_HOME}/oh-my-zsh.sh"
# Fix the `per-directory-history` plugin
# (this should be done by the plugin itself, but for some reason it does not work)
#bindkey $PER_DIRECTORY_HISTORY_TOGGLE per-directory-history-toggle-history
# Fix the `copybuffer` plugin
#bindkey 'O' copybuffer
# unset LESS environment variable: why does oh-my-zsh insists on having it set??
unset LESS

# PLUGINS: ZPLUG
# dependencies: apt install zplug
# dependencies: https://github.com/romkatv/nerd-fonts.git or https://github.com/ryanoasis/nerd-fonts
export ZPLUG_HOME="${HOME}/.local/share/zplug/"
[ -f ${ZPLUG_HOME}/init.zsh ] && source ${ZPLUG_HOME}/init.zsh || source /usr/share/zplug/init.zsh
# TODO: The self-manage hook fails on forked-repository (even
#zplug "mareq/zplug", hook-build: 'zplug --self-manage'
zplug "zplug/zplug", hook-build: 'zplug --self-manage'
zplug "mareq/zsh-autosuggestions", at:skel
zplug "mareq/zsh-syntax-highlighting", at:skel
zplug "mareq/zsh-history-substring-search", at:skel
zplug "mareq/cargo", at:skel
zplug "mareq/rust-lang_zsh-config", at:skel
zplug "mareq/powerlevel10k", at:skel, as:theme, depth:1
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"
# load plugins
if ! zplug check; then
  zplug install
fi
zplug load
setopt monitor
# substring history search colors
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=blue,fg=yellow,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=white,bold"
# allow fuzzy substring history search (any non-empty string value means "yes")
HISTORY_SUBSTRING_SEARCH_FUZZY="yes"
# return only unique results from substring history search (any non-empty string value means "yes")
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE="yes"
# autosuggestions strategy
ZSH_AUTOSUGGEST_STRATEGY=("completion" "history")

# KEYBINDINGS
# https://unix.stackexchange.com/questions/290392/backspace-in-zsh-stuck
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# backspace behavior equivalent to vim enhanced mode
bindkey -v '^?' backward-delete-char
# turn on the vi-mode
bindkey -v
# search history backwards
#bindkey '\C-p' history-beginning-search-backward
#bindkey '\eOA' history-beginning-search-backward
#bindkey '\e[A' history-beginning-search-backward
bindkey -M vicmd '\-' history-beginning-search-backward
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey '\C-p' history-substring-search-up
bindkey '\eOA' history-substring-search-up
bindkey '\e[A' history-substring-search-up
#bindkey -M vicmd '\-' history-substring-search-up
#bindkey -M vicmd 'k' history-substring-search-up
# search history forward
#bindkey '\C-n' history-beginning-search-forward
#bindkey '\eOB' history-beginning-search-forward
#bindkey '\e[B' history-beginning-search-forward
bindkey -M vicmd '+' history-beginning-search-forward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey '\C-n' history-substring-search-down
bindkey '\eOB' history-substring-search-down
bindkey '\e[B' history-substring-search-down
#bindkey -M vicmd '+' history-substring-search-down
#bindkey -M vicmd 'j' history-substring-search-down
# clear screen
bindkey '\C-l' clear-screen
# reload configuration
bindkey '\C-x\C-r' re-read-init-file

# AUTOCOMPLETE
# TODO: This does not work.
# https://unix.stackexchange.com/questions/153429/zshell-is-tab-completing-ambiguous-options/153430
#unsetopt no_menu_complete
# https://superuser.com/questions/148207/how-can-i-make-zsh-completion-behave-like-bash-completion
#setopt noautomenu
##setopt autolist
##unsetopt menu_complete
# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt bash_auto_list
setopt auto_menu
setopt list_ambiguous

# HISTORY
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
# Path to the history file
HISTFILE="${HOME}/.zsh_history"
# Number of history lines to keep in memory
HISTSIZE=4096
# Number of history lines to save to the disk
SAVEHIST=65536
# Append history to the history file (no overwriting)
setopt append_history
# Do not show duplicates
setopt hist_find_no_dups
# Do not save duplicates
setopt hist_ignore_all_dups
# Delete the duplicates first when HISTFILE size exceeds HISTSIZE{
setopt hist_expire_dups_first
# Ignore commands starting with space
setopt hist_ignore_space
# Record timestamp of commands in HISTFILE
setopt extended_history
# Immediately append to the history file (not only on exit), record timestamps
setopt inc_append_history_time
# Do not share history across terminals
setopt no_share_history
# Show command with history expansion to the user before running it
setopt hist_verify

# ADDITIONAL CONFIGURATION
export SHRC_D="${HOME}/.config/sh/"
for rcfile in $(find ${SHRC_D} -maxdepth 1 -type f -or -type l); do
  source "${rcfile}"
done


# vim: ts=2 sw=2 et



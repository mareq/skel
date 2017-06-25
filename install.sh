#/bin/sh

# Install symlinks to the dotfiles into the home directory of the current user.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Last change: 2017 Jun 25


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
data_dir="${script_dir}/dotfiles/."
target_dir=$HOME

bak_ext=".skel.bak"


for target_f in $(ls ${data_dir}); do
  source_f=${target_f}

  # OS: Linux
  if [[ "${target_f}" =~ ^.*\.os_lx.* ]]; then
    if [ "$(uname)" != "Linux" ]; then
      continue;
    fi
    source_f="$(echo -n ${target_f} | sed 's|.os_lx||')"
  fi
  # OS: Mac
  if [[ "${target_f}" =~ ^.*\.os_mac.* ]]; then
    if [ "$(uname)" != "Darwin" ]; then
      continue;
    fi
    source_f="$(echo -n ${target_f} | sed 's|.os_mac||')"
  fi
  # User: non-root
  if [[ "${target_f}" =~ ^.*\.usr_usr.* ]]; then
    if [ "$(whoami)" == "root" ]; then
      continue;
    fi
    source_f="$(echo -n ${target_f} | sed 's|.usr_usr||')"
  fi
  # User: root
  if [[ "${target_f}" =~ ^.*\.usr_root.* ]]; then
    if [ "$(whoami)" != "root" ]; then
      continue;
    fi
    source_f="$(echo -n ${target_f} | sed 's|.usr_root||')"
  fi

  if [ -e "${target_dir}/.${source_f}" ]; then
    mv "${target_dir}/.${source_f}" "${target_dir}/.${source_f}${bak_ext}"
  fi
  ln -s -v "${data_dir}/${target_f}" "${target_dir}/.${source_f}"
done


# vim: ts=2 sw=2 et



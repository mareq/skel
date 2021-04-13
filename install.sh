#!/usr/bin/env bash

# Install symlinks to the dotfiles into the home directory of the current user.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Last change: 2021 Apr 16


#set -x
#set -e

##############################################################################
# CONSTANTS: Generic Values
##############################################################################

# program name (used in logs)
PRGNAME="skel: install.sh"
# log-levels
LOG_FATAL="FATAL"
LOG_ERROR="Error"
LOG_WARN="Warning"
LOG_INFO="Info"
LOG_DEBUG="Debug"
LOG_TRACE="Trace"
LOG_TEST="Test"
LOG_TEST_PASS="${LOG_TEST}: Passed: "
LOG_TEST_FAIL="${LOG_TEST}: Failed: "
LOG_TEST_ASSERT_FAIL="${LOG_TEST}: Assertion Failed: "
# script directory
get_script_dir () {
   SCRIPT_FILE="${0}"
   # while ${SCRIPT_FILE} is a symlink, resolve it
   while [ -h "${SCRIPT_FILE}" ]; do
      SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_FILE}")" && pwd)"
      SCRIPT_FILE="$(readlink "${SCRIPT_FILE}")"
      # if ${SCRIPT_FILE} was a relative symlink
      # (so no `/` as prefix, need to resolve it relative to the symlink base directory)
      [[ "${SCRIPT_FILE}" =~ ^/.* ]] || SCRIPT_FILE="${SCRIPT_DIR}/${SCRIPT_FILE}"
   done
   SCRIPT_DIR="$( cd -P "$( dirname "${SCRIPT_FILE}" )" && pwd )"
   echo "${SCRIPT_DIR}"
}
SCRIPT_DIR="$(get_script_dir)"

##############################################################################
# CONSTANTS: Script-Specific Values
##############################################################################

# configuration constants
# - rc-files:
#   regexp: /${SEP_SKEL}${RCF}(${SEP_FLAG}<flag>)*${SEP_SKEL}filename/
#   e.g.: `__rc.f__.vimrc`
#   e.g.: `__rc.f_m-tpl_os-lx_u-user__.gitconfig`
# - rc-directories:
#   regexp: /${SEP_SKEL}${RCD}(${SEP_FLAG}<flag>)*${SEP_SKEL}filename/
#   e.g.: `__rc.d__.vim`
#   e.g.: `__rc.d_m-ln_os-lx_u-user__.config`
# - <flag> (used in definitions above):
#   regextp: /<flag-key>${SEP_FGKV}<flag-value>
#   e.g.: `m-tpl`
#   e.g.: `os-lx`
#   e.g.: `u-root`
NULL='-'          # empty value
RCF='rc-f'        # rc-file magic value
RCD='rc-d'        # rc-directory magic value
RCX='__rc-x__'    # magic value to be removed from source subdirectory names (e.g. so that they do not need to start with dot)
SEP_SKEL='__'     # main separator
SEP_FLAG='_'      # flag-separator
SEP_FGKV='-'      # key-value separator
FGK_M='m'         # flag key: method
FGV_M_LN='ln'     # flag value: method: symlink file
FGV_M_HL='hl'     # flag value: method: hardlink file
FGV_M_CP='cp'     # flag value: method: copy file
FGV_M_TPL='tpl'   # flag value: method: template with environment variables (copy and resolve env-vars)
FGK_OS='os'       # flag key: operating system
FGV_OS_LX='lx'    # flag value: operating system: Linux
FGV_OS_MAC='mac'  # flag value: operating system: Mac OS
FGK_U='u'         # flag key: user
FGV_U_USER='user' # flag value: user: normal user
FGV_U_ROOT='root' # flag value: user: root user

##############################################################################
# CONFIGURATION: Configuration Values
##############################################################################

DRY_RUN="${DRY_RUN:-""}"
TMP="$(realpath -s "${PREFIX:-${HOME}}" 2> /dev/null)"
if [ ${?} -ne 0 ]; then
  echo "${PRGNAME}: ${LOG_FATAL}: Invalid prefix: \`${PREFIX:-${HOME}}\`"
  exit 1
fi
PREFIX="${TMP}"
TMP="$(realpath -s "${DATA_DIR:-${SCRIPT_DIR}/rc.d}" 2> /dev/null)"
if [ ${?} -ne 0 ]; then
  echo "${PRGNAME}: ${LOG_FATAL}: Invalid data directory: \`${DATA_DIR:-${SCRIPT_DIR}/rc.d}\`"
  exit 1
fi
DATA_DIR="${TMP}"
BAK_EXT="${BAK_EXT:-".skel-$(date --iso-8601=date)-backup"}"
UNAME_S="$(uname -s)"
if [ "x${FLAG_OS}" != "x" ]; then
  FLAG_OS="${FLAG_OS}"
elif [[ ${UNAME_S} =~ .*Linux.* ]]; then
  FLAG_OS="${FGV_OS_LX}"
elif [[ ${UNAME_S} =~ .*Darwin.* ]]; then
  FLAG_OS="${FGV_OS_MAC}"
else
  FLAG_OS="unknown"
fi
FLAG_USER="${FLAG_USER:-$([ $(id -u) = 0 ] && echo "${FGV_U_ROOT}" || echo ${FGV_U_USER})}"
if [ "x${DRY_RUN}" = "x" ]; then
  echo "${PRGNAME}: ${LOG_INFO}: dry run: no"
else
  echo "${PRGNAME}: ${LOG_INFO}: dry run: yes"
fi
echo "${PRGNAME}: ${LOG_INFO}: prefix: \`${PREFIX}\`"
echo "${PRGNAME}: ${LOG_INFO}: data directory: \`${DATA_DIR}\`"
echo "${PRGNAME}: ${LOG_INFO}: backup extension: \`${BAK_EXT}\`"
echo "${PRGNAME}: ${LOG_INFO}: flags: os=\`${FLAG_OS}\` user=\`${FLAG_USER}\`"

##############################################################################
# IMPLEMENTATION: Functions
##############################################################################

# Parse rc-file
# inputs:
# - IN_NAME: name of the rc-file (including its path from `${DATA_DIR}`)
# - IN_MAGIC: magic header value (one of: `${RCF}`, `${RCD}`)
# outputs: echo to `stdout`, one value per line
# - RC_VALID: valid flag
# - RC_DIR: directory (relative to ${DATA_DIR})
# - RC_NAME: rc-file/rc-directory name
# - RC_FG_M: flags: method
# - RC_FG_OS: flags: operating-system
# - RC_FG_U: flags: user
parse_name() {
  local IN_NAME="${1}"
  local IN_MAGIC="${2:-"${RCF}"}"

  local RC_BASENAME="$(basename "${IN_NAME}")"
  local RC_FLAGS="$(echo "${RC_BASENAME}" | awk -F"${SEP_SKEL}" '{ print $2 }')"
  local RC_NAME="$(echo "${RC_BASENAME}" | sed "s/^${SEP_SKEL}${RC_FLAGS}${SEP_SKEL}//")"
  local RC_DIR="$(dirname "${IN_NAME}")"

  local RC_FG_M="${FGV_M_LN}"
  local RC_FG_OS=""
  local RC_FG_U=""
  local RC_VALID=1
  >&2 echo "${PRGNAME}: ${LOG_TRACE}: ${FUNCNAME}: IN_MAGIC: \`${IN_MAGIC}\`"
  for FGKV in $(echo "${RC_FLAGS}" | awk -F"${SEP_FLAG}" '{ for(i=1;i<=NF;i++) print $i }'); do
    >&2 echo "${PRGNAME}: ${LOG_TRACE}: ${FUNCNAME}: FGKV: \`${FGKV}\`"
    [ "${FGKV}" = "${IN_MAGIC}" ] && continue
    local FGK="$(echo "${FGKV}" | awk -F"${SEP_FGKV}" '{ print $1 }')"
    >&2 echo "${PRGNAME}: ${LOG_TRACE}: ${FUNCNAME}: FGK: \`${FGK}\`"
    local FGV="$(echo "${FGKV}" | awk -F"${SEP_FGKV}" 'BEGIN{OFS = FS} { $1=""; sub(OFS, ""); }1')"
    >&2 echo "${PRGNAME}: ${LOG_TRACE}: ${FUNCNAME}: FGV: \`${FGV}\`"
    case "${FGK}" in
      "${FGK_M}")
        if [ "${IN_MAGIC}" == "${RCF}" ] && [[ "${FGV}" =~ ^("${FGV_M_LN}"|"${FGV_M_HL}"|"${FGV_M_CP}"|"${FGV_M_TPL}")$ ]]; then
          RC_FG_M="${FGV}"
        elif [ "${IN_MAGIC}" == "${RCD}" ] && [[ "${FGV}" =~ ^("${FGV_M_LN}"|"${FGV_M_CP}")$ ]]; then 
          RC_FG_M="${FGV}"
        else
          >&2 echo "${PRGNAME}: ${LOG_DEBUG}: Unsupported installation method: \`${FGV}\`"
          RC_VALID=0
        fi
        ;;
      "${FGK_OS}")
        if [[ "${FGV}" =~ ^("${FGV_OS_LX}"|"${FGV_OS_MAC}")$ ]]; then
          RC_FG_OS="${FGV}"
        else
          >&2 echo "${PRGNAME}: ${LOG_DEBUG}: Unsupported operating system: \`${FGV}\`"
          RC_VALID=0
        fi
        ;;
      "${FGK_U}")
        if [[ "${FGV}" =~ ^("${FGV_U_USER}"|"${FGV_U_ROOT}")$ ]]; then
          RC_FG_U="${FGV}"
        else
          >&2 echo "${PRGNAME}: ${LOG_DEBUG}: Unsupported user: \`${FGV}\`"
          RC_VALID=0
        fi
        ;;
      *)
        >&2 echo "${PRGNAME}: ${LOG_DEBUG}: Unsupported flag: \`${FGK}\`"
        RC_VALID=0
        ;;
    esac
  done

  # valid flag
  echo "${RC_VALID:-"${NULL}"}"
  # directory (relative to ${DATA_DIR})
  echo "${RC_DIR:-"${NULL}"}"
  # rc-file/rc-directory name
  echo "${RC_NAME:-"${NULL}"}"
  # flags: method
  echo "${RC_FG_M:-"${NULL}"}"
  # flags: operating-system
  echo "${RC_FG_OS:-"${NULL}"}"
  # flags: user
  echo "${RC_FG_U:-"${NULL}"}"
}

# Install rc-file
# inputs:
# - IN_RC_FILE: original rc-file path (relative to ${DATA_DIR}, including file name)
# - IN_MAGIC: magic header value (one of: `${RCF}`, `${RCD}`)
# - IN_RC_VALID: valid flag
# - IN_RC_DIR: directory (relative to ${DATA_DIR})
# - IN_RC_NAME: rc-file/rc-directory name
# - IN_RC_FG_M: flags: method
# - IN_RC_FG_OS: flags: operating-system
# - IN_RC_FG_U: flags: user
install_rc_file() {
  local IN_RC_FILE="${1}"
  local IN_MAGIC="${2}"
  local IN_RC_FGVALID="${3}"
  local IN_RC_DIR="${4}"
  local IN_RC_NAME="${5}"
  local IN_RC_FG_M="${6}"
  local IN_RC_FG_OS="${7}"
  local IN_RC_FG_U="${8}"

  if [ ${IN_RC_FGVALID} -eq 1 ]; then
    local LOG_FG_OS=$([ "x${RC_FG_OS}" = "x" ] && echo "any" || echo "${RC_FG_OS}")
    local LOG_FG_U=$([ "x${RC_FG_U}"  = "x" ] && echo "any" || echo "${RC_FG_U}")
    echo "${PRGNAME}: ${LOG_DEBUG}: \`${IN_RC_FILE}\`: dir=\`${IN_RC_DIR}\` rc-name=\`${IN_RC_NAME}\` method=\`${IN_RC_FG_M}\` os=\`${LOG_FG_OS}\` user=\`${LOG_FG_U}\`"
  else
    echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Skipping due to usupported flags..."
    return 1
  fi

  if [ "${IN_RC_FG_OS}" != "${NULL}" ] && [ "${IN_RC_FG_OS}" != "${FLAG_OS}" ]; then
    echo "${PRGNAME}: ${LOG_DEBUG}: \`${IN_RC_FILE}\`: Incompatible operating system: Skipping..."
    return 0
  fi
  if [ "${IN_RC_FG_U}" != "${NULL}" ] && [ "${IN_RC_FG_U}" != "${FLAG_USER}" ]; then
    echo "${PRGNAME}: ${LOG_DEBUG}: \`${IN_RC_FILE}\`: Incompatible user: Skipping..."
    return 0
  fi

  local IN_RC_DIR_MAGIC=$(echo "${IN_RC_DIR}" | sed "s/${RCX}//g")
  local TARGET_DIR="${PREFIX}/${IN_RC_DIR_MAGIC}"
  if ! [ -d "${TARGET_DIR}"  ]; then
    echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Installation path does not exist: \`${PREFIX}/${IN_RC_DIR}\`: Skipping..."
    return 1
  fi
  TARGET_DIR="$(realpath -s -e "${TARGET_DIR}" 2>/dev/null)"
  if [ ${?} -ne 0 ]; then
    echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Installation path does not exist: \`${PREFIX}/${IN_RC_DIR}\`: Skipping..."
    return 1
  fi

  local TARGET_FILE="${TARGET_DIR}/${IN_RC_NAME}"

  local SOURCE_FILE="${DATA_DIR}/${IN_RC_FILE}"
  if ! [ -e "${SOURCE_FILE}"  ]; then
    # this is fatal b/c the source paths is produced by `find` (proverbial last words: this should never happen)
    echo "${PRGNAME}: ${LOG_FATAL}: \`${IN_RC_FILE}\`: Source file does not exist: \`${DATA_DIR}/${IN_RC_FILE}\`: Skipping..."
    exit 1
  fi
  SOURCE_FILE="$(realpath -s -e "${SOURCE_FILE}" 2>/dev/null)"
  if [ ${?} -ne 0 ]; then
    # this is fatal b/c the source paths is produced by `find` (proverbial last words: this should never happen)
    echo "${PRGNAME}: ${LOG_FATAL}: \`${IN_RC_FILE}\`: Source file does not exist: \`${DATA_DIR}/${IN_RC_FILE}\`: Skipping..."
    exit 1
  fi

  local BAK_TARGET="${TARGET_FILE}${BAK_EXT}"
  while [ -e "${BAK_TARGET}" ]; do
    BAK_TARGET="${BAK_TARGET}${BAK_EXT}"
  done

  case "${IN_RC_FG_M}" in
    "${FGV_M_LN}")
      if [ -e "${TARGET_FILE}" ] || [ -h "${TARGET_FILE}" ]; then
        local LINK_TARGET="$(readlink "${TARGET_FILE}")"
        if [ -h "${TARGET_FILE}" ] && [ "${LINK_TARGET}" == "${SOURCE_FILE}" ]; then
          echo "${PRGNAME}: ${LOG_DEBUG}: \`${IN_RC_FILE}\`: Already installed: Skipping..."
          return 0
        fi
        if [ "x${DRY_RUN}" = "x" ]; then
          local ERR
          ERR=$(mv "${TARGET_FILE}" "${BAK_TARGET}" 2>&1)
          local RC=${?}
        else
          local ERR=""
          local RC=0
        fi
        if [ ${RC} -eq 0 ]; then
          echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Already exists: Backed up to \`${BAK_TARGET}\`"
        else
          echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Already existss: Unable to back up the original file: \`${ERR}\`"
          return 1
        fi
      fi
      if [ "x${DRY_RUN}" = "x" ]; then
        local ERR
        ERR=$(ln -s -v "${SOURCE_FILE}" "${TARGET_FILE}" 2>&1)
        local RC=${?}
      else
        local ERR=""
        local RC=0
      fi
      if [ ${RC} -eq 0 ]; then
        echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Installed to \`${TARGET_FILE}\` using method \`${IN_RC_FG_M}\`"
      else
        echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Unable to install using method \`${IN_RC_FG_M}\`: \`${ERR}\`"
        return 1
      fi
      ;;
    "${FGV_M_HL}")
      if [ -e "${TARGET_FILE}" ] || [ -h "${TARGET_FILE}" ]; then
        if [ "x${DRY_RUN}" = "x" ]; then
          local ERR
          ERR=$(mv "${TARGET_FILE}" "${BAK_TARGET}" 2>&1)
          local RC=${?}
        else
          local ERR=""
          local RC=0
        fi
        if [ ${RC} -eq 0 ]; then
          echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Already exists: Backed up to \`${BAK_TARGET}\`"
        else
          echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Already existss: Unable to back up the original file: \`${ERR}\`"
          return 1
        fi
      fi
      if [ "x${DRY_RUN}" = "x" ]; then
        local ERR
        ERR=$(ln -v "${SOURCE_FILE}" "${TARGET_FILE}" 2>&1)
        local RC=${?}
      else
        local ERR=""
        local RC=0
      fi
      if [ ${RC} -eq 0 ]; then
        echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Installed to \`${TARGET_FILE}\` using method \`${IN_RC_FG_M}\`"
      else
        echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Unable to install using method \`${IN_RC_FG_M}\`: \`${ERR}\`"
        return 1
      fi
      ;;
    "${FGV_M_CP}")
      if [ -e "${TARGET_FILE}" ] || [ -h "${TARGET_FILE}" ]; then
        if [ "x${DRY_RUN}" = "x" ]; then
          local ERR
          ERR=$(mv "${TARGET_FILE}" "${BAK_TARGET}" 2>&1)
          local RC=${?}
        else
          local ERR=""
          local RC=0
        fi
        if [ ${RC} -eq 0 ]; then
          echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Already exists: Backed up to \`${BAK_TARGET}\`"
        else
          echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Already existss: Unable to back up the original file: \`${ERR}\`"
          return 1
        fi
      fi
      if [ "x${DRY_RUN}" = "x" ]; then
        local CPDIR=$([ "${IN_MAGIC}" = "${RCD}" ] && echo '-r')
        local ERR
        ERR=$(cp ${CPDIR} "${SOURCE_FILE}" "${TARGET_FILE}" 2>&1)
        local RC=${?}
      else
        local ERR=""
        local RC=0
      fi
      if [ ${RC} -eq 0 ]; then
        echo "${PRGNAME}: ${LOG_INFO}: \`${IN_RC_FILE}\`: Installed to \`${TARGET_FILE}\` using method \`${IN_RC_FG_M}\`"
      else
        echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Unable to install using method \`${IN_RC_FG_M}\`: \`${ERR}\`"
        return 1
      fi
      ;;
    "${FGV_M_TPL}")
      echo "${PRGNAME}: ${LOG_ERROR}: \`${IN_RC_FILE}\`: Installation method \`${IN_RC_FG_M}\` not implemented: Skipping..."
      return 1
      ;;
    *)
      # this is fatal b/c it should have been checked by the `parse_name` function already
      echo "${PRGNAME}: ${LOG_FATAL}: \`${IN_RC_FILE}\`: Invalid installation method: \`${IN_RC_FG_M}\`"
      exit 1
  esac

}

##############################################################################
# IMPLEMENTATION: Main
##############################################################################

# Main The Entrypont (Note: it's recursive)
main() {
  local IN_DIR=${1}
  echo "${PRGNAME}: ${LOG_DEBUG}: Processing source directory: \`${DATA_DIR}/${IN_DIR}\`"

  local SAVEIFS="${IFS}"
  IFS="$(echo -en "\n\b")"

  # first, process rc-files
  local FIND_NAME="${SEP_SKEL}${RCF}*${SEP_SKEL}*"
  for RC_FILE in $(cd "${DATA_DIR}" && find "${IN_DIR}" -mindepth 1 -maxdepth 1 -type f -and -name "${FIND_NAME}" ); do
    local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
    install_rc_file "${RC_FILE}" "${RCF}" ${RC_INFO[@]}
  done
  # second, process rc-dirs
  local FIND_NAME="${SEP_SKEL}${RCD}*${SEP_SKEL}*"
  for RC_FILE in $(cd "${DATA_DIR}" && find "${IN_DIR}" -mindepth 1 -maxdepth 1 -type d -and -name "${FIND_NAME}" ); do
    local RC_INFO=($(parse_name "${RC_FILE}" "${RCD}"))
    install_rc_file "${RC_FILE}" "${RCD}" ${RC_INFO[@]}
  done
  # last, recurse into non-rc-dirs
  for RC_FILE in $(cd "${DATA_DIR}/${IN_DIR}" && find . -mindepth 1 -maxdepth 1 -type d -and -not -name "${FIND_NAME}" -printf "%P\n"); do
    DIR=$(realpath --relative-to="${DATA_DIR}" -s -e "${DATA_DIR}/${IN_DIR}/${RC_FILE}")
    main "${DIR}"
  done

  IFS="${SAVEIFS}"
}
[ "x${SKEL_RUN_TESTS}" = "x" ] && main "." 2>&1 |
  #grep -v "${PRGNAME}: ${LOG_FATAL}:" |
  #grep -v "${PRGNAME}: ${LOG_ERROR}:" |
  #grep -v "${PRGNAME}: ${LOG_WARN}:" |
  #grep -v "${PRGNAME}: ${LOG_INFO}:" |
  grep -v "${PRGNAME}: ${LOG_DEBUG}:" |
  grep -v "${PRGNAME}: ${LOG_TRACE}:"

##############################################################################
# TESTS: Assertions
##############################################################################

# Assertion: Compare strings for equality
assert_eq_str() {
  local IN_EXPECTED="${1}"
  local IN_VALUE="${2}"
  local IN_MESSAGE="${3}"
  local IN_LOG_HEADER="${4:-"${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: "}"

  local RESULT=0
  if [ "${IN_EXPECTED}" != "${IN_VALUE}" ]; then
    echo "${IN_LOG_HEADER}: ${IN_MESSAGE}: \`${IN_EXPECTED}\` != \`${IN_VALUE}\`"
    RESULT=1
  fi

  return ${RESULT}
}

# Assertion: Compare integers for equality
assert_eq_int() {
  local IN_EXPECTED="${1}"
  local IN_VALUE="${2}"
  local IN_MESSAGE="${3}"
  local IN_LOG_HEADER="${4:-"${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: "}"

  local RESULT=0
  if [ ${IN_EXPECTED} -ne ${IN_VALUE} ]; then
    echo "${IN_LOG_HEADER}: ${IN_MESSAGE}: \`${IN_EXPECTED}\` != \`${IN_VALUE}\`"
    RESULT=1
  fi

  return ${RESULT}
}

##############################################################################
# TESTS: Unit-Tests
##############################################################################

# TestCase: Parse simple rc-file name
test_parse_name_simple_file() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="./${SEP_SKEL}${RCF}${SEP_SKEL}.vimrc"
  assert_eq_str \
    './__rc-f__.vimrc' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.vimrc' "${RC_NAME}" "Wrong rc-file name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_LN}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse simple rc-dir name
test_parse_name_simple_dir() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="./${SEP_SKEL}${RCD}${SEP_SKEL}.vim"
  assert_eq_str \
    './__rc-d__.vim' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCD}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.vim' "${RC_NAME}" "Wrong rc-file name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_LN}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name with all attributes set
test_parse_name_file_with_all_attributes() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE=".config/git/"                                     # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_M}${SEP_FGKV}${FGV_M_TPL}"   # method: template
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_OS}${SEP_FGKV}${FGV_OS_LX}"  # os: linux
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}${FGV_U_USER}"  # user: normal user
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}.gitconfig"                                   # rc-file name
  assert_eq_str \
    '.config/git/__rc-f_m-tpl_os-lx_u-user__.gitconfig' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.config/git' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.gitconfig' "${RC_NAME}" "Wrong rc-dir name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_TPL}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_OS_LX}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_U_USER}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-dir name with all attributes set
test_parse_name_dir_with_all_attributes() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE=".local/share/"                                    # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCD}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_M}${SEP_FGKV}${FGV_M_CP}"    # method: verbatim copy
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_OS}${SEP_FGKV}${FGV_OS_LX}"  # os: linux
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}${FGV_U_USER}"  # user: normal user
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}zplug"                                        # rc-dir name
  assert_eq_str \
    '.local/share/__rc-d_m-cp_os-lx_u-user__zplug' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCD}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '.local/share' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str 'zplug' "${RC_NAME}" "Wrong rc-dir name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_CP}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_OS_LX}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_U_USER}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name that contains spaces
test_parse_name_file_with_spaces() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="directory path/full of spaces/"                   # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}${FGV_U_ROOT}"  # user: root user
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}. filename with spaces"                       # rc-file name
  assert_eq_str \
    'directory path/full of spaces/__rc-f_u-root__. filename with spaces' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  # the `IFS` here is necessary for return array to be parsed correctly (its values contain spaces)
  local SAVEIFS="${IFS}"
  IFS="$(echo -en "\n\b")"
  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  IFS="${SAVEIFS}"
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str 'directory path/full of spaces' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str '. filename with spaces' "${RC_NAME}" "Wrong rc-file name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_LN}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_U_ROOT}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name bad, wrong magic value
test_parse_name_file_invalid_wrong_magic_value() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="./${SEP_SKEL}${RCF}${RCF}${SEP_SKEL}.vimrc"  # the magic value is there twice
  assert_eq_str \
    './__rc-frc-f__.vimrc' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # the magic value is invalid, the file should not pass the checks
  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should not be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name bad, wrong os-flag
test_parse_name_file_invalid_wrong_os() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="directory path/full of spaces/"                   # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_SKEL}${FGK_OS}${SEP_FGKV}win"           # os: windows is not supported (yet?)
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}. filename with spaces"                       # rc-file name
  assert_eq_str \
    'directory path/full of spaces/__rc-f__os-win__. filename with spaces' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  # the `IFS` here is necessary for return array to be parsed correctly (its values contain spaces)
  local SAVEIFS="${IFS}"
  IFS="$(echo -en "\n\b")"
  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  IFS="${SAVEIFS}"
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # the magic value is invalid, the file should not pass the checks
  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should no be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name bad, wrong user-flag
test_parse_name_file_invalid_wrong_user() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE=".config/nvim"                              # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                     # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}dennis"  # user: this is flag to distinguish b/w normal and root user, not the username
  RC_FILE="${RC_FILE}${SEP_SKEL}"                           # end header
  RC_FILE="${RC_FILE}init.vim"                              # rc-file name
  assert_eq_str \
    '.config/nvim__rc-f_u-dennis__init.vim' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # the magic value is invalid, the file should not pass the checks
  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should not be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name bad, wrong separator
test_parse_name_file_invalid_wrong_main_separator() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="directory path/full of spaces/"                   # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_SKEL}${FGK_U}${SEP_FGKV}${FGV_U_ROOT}"  # user: root user (has wrong separator: should be `${SEP_FLAG}`)
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}. filename with spaces"                       # rc-file name
  assert_eq_str \
    'directory path/full of spaces/__rc-f__u-root__. filename with spaces' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  # the `IFS` here is necessary for return array to be parsed correctly (its values contain spaces)
  local SAVEIFS="${IFS}"
  IFS="$(echo -en "\n\b")"
  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  IFS="${SAVEIFS}"
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # this is pathological case: the rc-file name is still correct according to the grammar, but it is semantically wrong
  assert_eq_int 1 ${RC_FGVALID} "The valid-flag should be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str 'directory path/full of spaces' "${RC_DIR}" "Wrong directory name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  # the parsed file name is wrong (contains part of the attributes)
  assert_eq_str "${FGK_U}${SEP_FGKV}${FGV_U_ROOT}${SEP_SKEL}. filename with spaces" "${RC_NAME}" "Wrong rc-file name" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${FGV_M_LN}" "${RC_FG_M}" "Wrong method flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  assert_eq_str "${NULL}" "${RC_FG_OS}" "Wrong operating-system flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  # the user attribute has not been parsed (it is included in filename)
  assert_eq_str "${NULL}" "${RC_FG_U}" "Wrong user flag" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-file name bad, wrong flag separator
test_parse_name_file_invalid_wrong_flag_separator() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="./"                                               # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_M}${SEP_FGKV}${FGV_M_HL}"    # method: hard-link
  RC_FILE="${RC_FILE}${SEP_FGKV}${FGK_OS}${SEP_FGKV}${FGV_OS_LX}"  # os: linux (has wrong separator: should be `${SEP_FLAG}`)
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}${FGV_U_USER}"  # user: normal user
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}.tmux.conf"                                   # rc-file name
  assert_eq_str \
    './__rc-f_m-hl-os-lx_u-user__.tmux.conf' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # flags are not separated correctly, the file should not pass the checks
  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should not be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestCase: Parse rc-dir name bad, wrong method flag (acceptable for file, not acceptable for dir)
test_parse_name_dir_invalid_flag_value_for_dir() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE=".local/share/"                                    # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCD}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_M}${SEP_FGKV}${FGV_M_HL}"    # method: hard link (there is no such thing as directory hard link)
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}zplug"                                        # rc-dir name
  assert_eq_str \
    '.local/share/__rc-d_m-hl__zplug' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCD}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should not be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}


# TestCase: Parse rc-file name bad, wrong key-value separator
test_parse_name_file_invalid_wrong_keyvalue_separator() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST_ASSERT_FAIL}: ${FUNCNAME}"

  local RC_FILE="./"                                               # directory
  RC_FILE="${RC_FILE}${SEP_SKEL}${RCF}"                            # start header
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_M}${SEP_FGKV}${FGV_M_CP}"    # method: verbatim copy
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_OS}${SEP_FLAG}${FGV_OS_LX}"  # os: linux (has wrong separator: should be `${SEP_FGKV}`)
  RC_FILE="${RC_FILE}${SEP_FLAG}${FGK_U}${SEP_FGKV}${FGV_U_ROOT}"  # user: root
  RC_FILE="${RC_FILE}${SEP_SKEL}"                                  # end header
  RC_FILE="${RC_FILE}.tmux.conf"                                   # rc-file name
  assert_eq_str \
    './__rc-f_m-cp_os_lx_u-root__.tmux.conf' \
    "${RC_FILE}" \
    "Wrong test input: Have the default values chaged?" \
    "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  local RC_INFO=($(parse_name "${RC_FILE}" "${RCF}"))
  local RC_FGVALID="${RC_INFO[0]}"
  local RC_DIR="${RC_INFO[1]}"
  local RC_NAME="${RC_INFO[2]}"
  local RC_FG_M="${RC_INFO[3]}"
  local RC_FG_OS="${RC_INFO[4]}"
  local RC_FG_U="${RC_INFO[5]}"

  # flags are not separated correctly, the file should not pass the checks
  assert_eq_int 0 ${RC_FGVALID} "The valid-flag should not be set" "${LOG_HEADER}"
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed assertions: ${PASS_CNT}, failed assertions: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# TestSuite: Parse rc-file name
test_parse_name() {
  local PASS_CNT=0
  local FAIL_CNT=0
  local LOG_HEADER="${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}"
  echo "${LOG_HEADER}: Running tests..."

  test_parse_name_simple_file
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_simple_dir
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_with_all_attributes
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_dir_with_all_attributes
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_with_spaces
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_invalid_wrong_magic_value
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_invalid_wrong_user
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_invalid_wrong_main_separator
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_invalid_wrong_flag_separator
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_dir_invalid_flag_value_for_dir
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))
  test_parse_name_file_invalid_wrong_keyvalue_separator
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: ${FUNCNAME}: passed test-cases: ${PASS_CNT}, failed test-cases: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}

# Test: Run tests
test() {
  local PASS_CNT=0
  local FAIL_CNT=0
  echo "${PRGNAME}: ${LOG_TEST}: Running tests..."

  test_parse_name
  [ ${?} -eq 0 ] && PASS_CNT=$((PASS_CNT+1)) || FAIL_CNT=$((FAIL_CNT+1))

  echo "${PRGNAME}: ${LOG_TEST}: passed test-suites: ${PASS_CNT}, failed test-suites: ${FAIL_CNT}"
  [ ${FAIL_CNT} -eq 0 ] && return 0 || return 1
}
[ "x${SKEL_RUN_TESTS}" != "x" ] && test 2>&1 |
  #grep -v "${PRGNAME}: ${LOG_FATAL}:" |
  #grep -v "${PRGNAME}: ${LOG_ERROR}:" |
  #grep -v "${PRGNAME}: ${LOG_WARN}:" |
  #grep -v "${PRGNAME}: ${LOG_INFO}:" |
  grep -v "${PRGNAME}: ${LOG_DEBUG}:" |
  grep -v "${PRGNAME}: ${LOG_TRACE}:"


# vim: ts=2 sw=2 et



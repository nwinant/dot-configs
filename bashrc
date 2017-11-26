###|  EDC ~/.bashrc
 ##|  
 ##|  See:  https://github.com/nwinant/edc-configs
 ##|  
 ##|  Author: Nathan Winant <nw@exegetic.net>
 ###

##====|  Utility functions  |================================================##

echo_stderr() {
  echo "$@" >&2
}

print_log_msg() {
  if [ ! -z  "$log_timestamp_format" ]; then
    local -r timestamp=" [$( date +${log_timestamp_format} )]"
  else
    local -r timestamp=""
  fi
  echo_stderr "$1${timestamp}${log_script_name}:  ${@:2}"
}

log_err() {
  print_log_msg "ERROR" "$@"
}

log_warn() {
  print_log_msg "WARN " "$@"
}

##|  Source file, if it exists.
 #|  
safely_source() {
  local -r file=$1
  if [ -f "${file}" ]; then
    #echo "Sourcing $file"
    source $file
  #else log_warn "Could not source" "$file" "YEAH!"
  fi
}

##|  Source all *.sh and *.bash files in a directory.
 #|  
source_bash_dir() {
  local -r dir=$1
  for file in $(ls $dir/*.{sh,bash} 2>/dev/null); do
    source $file
  done
}

##|  If directory exists, add it to the beginning of PATH.
 #|  
prepend_dir_to_path() {
  local -r dir=$1
  if [ -d "${dir}" ]; then
    PATH=${dir}:$PATH
  fi
}

##|  Abstraction layer for determining platform.
 #|  
determine_platform() {
  case "$( uname )" in
    Linux)   echo -n "linux"   ;;
    Darwin)  echo -n "osx"     ;;
    FreeBSD) echo -n "freebsd" ;;
  esac
}

##====|  Init functions  |===================================================##

edc_setup_vars() {
  export edc_home=${default_edc_home:-~/.edc.d}
  local_edc_home=${default_local_edc_home:-$edc_home/local}

  #log_timestamp_format='%Y%m%d-%H:%M:%S'
  log_script_name=" [$( basename ${BASH_SOURCE[0]} )]"

  export platform=$( determine_platform )
  export user_full_name=${USER}

  ##|  Source pre-hook:
  safely_source "$local_edc_home/bashrc-pre-hook"

  if [[ "${platform}" == 'linux' ]]; then
    user_full_name=$( getent passwd $LOGNAME | cut -d: -f5 | cut -d, -f1 )
  elif [[ "${platform}" == 'osx' ]]; then
    user_full_name=$( finger $LOGNAME | head -1 | awk -F': ' '{print $3}' )
  elif [[ "${platform}" == 'freebsd' ]]; then
    ##|  Nothing special, yet.
    :
  else
    log_warn "Could not determine platform:" ${platform}
  fi
}

edc_setup_paths() {
  bashrc_d=${default_bashrc_d:-~/.bashrc.d}
  aliases_home=${default_aliases_home:-${edc_home}/aliases}
  bin_home=${default_bin_home:-${edc_home}/bin}
  lib_home=${default_lib_home:-${edc_home}/lib}
  local local_aliases_home=${default_local_aliases_home:-~/aliases}
  local local_bin_home=${default_local_bin_home:-~/bin}
  local local_scripts_home=${default_local_scripts_home:-~/scripts}
  local os_dir="$platform"

  ##|  Read local bashrc, if present, allowing config vars to be overridden
   #|  before making it into the PATH:
  safely_source "${default_local_bashrc:-$local_edc_home/bashrc}"

  ##|  These should always be on the path:
  PATH=$aliases_home:$bin_home:$PATH

  ##|  Add platform-specific dirs to PATH, if any:
  if [ "$platform" != "unknown" ]; then
    prepend_dir_to_path "${aliases_home}/${os_dir}"
    prepend_dir_to_path "${bin_home}/${os_dir}"
  fi

  ##|  Add any local dirs:
  prepend_dir_to_path "${local_bin_home}"
  prepend_dir_to_path "${local_aliases_home}"
  prepend_dir_to_path "${local_scripts_home}"
}

edc_export_bash_vars() {
  export docs_home=${default_docs_home:-${edc_home}/docs}
  export templates_home=${default_templates_home:-${edc_home}/templates}
  export PATH

  ##|  Ensure there are no surprises when we cd:
  export CDPATH=.

  #export INPUTRC=~/.inputrc
  #export INPUTRC=/etc/inputrc
  export EDITOR=emacs
  export SVN_EDITOR=vim
  export BROWSER=google-chrome

  ##|  History:
  export HISTIGNORE="ls:pwd:clear:history:h"
  export HISTTIMEFORMAT='| %Y-%m-%d %H:%M:%S |  '
  export HISTSIZE=40000
  export HISTFILESIZE=$(( $HISTSIZE * 10 ))
  #export HISTCONTROL="erasedups:ignorespace"
}

edc_source_post_hooks() {
  local -r local_bashrc_d=${default_local_bashrc_d:-$local_edc_home/bashrc.d}
  local -r os_dir="$platform"
  ##|  Attempt to source bash_completion for git (used for PS1)
  if [[ $PS1 ]]; then
    ##|  Linux:
    safely_source /usr/share/bash-completion/bash_completion
    #safely_source /usr/local/etc/bash_completion.d/git-completion.bash
    #safely_source /usr/local/git/contrib/completion/git-completion.bash
    ##|  OS X:
    safely_source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
    safely_source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
  fi

  source ${lib_home}/ansi-codes.sh
  source_bash_dir ${bashrc_d}/lib
  source_bash_dir ${bashrc_d}

  ##|  Source platform-specific files, if any
  if [ "$platform" != "unknown" ]; then
    source_bash_dir ${bashrc_d}/lib/${os_dir}
    source_bash_dir ${bashrc_d}/${os_dir}
  fi

  ##|  Source local files, if any
  if [ -d "${local_bashrc_d}" ]; then
    source_bash_dir ${local_bashrc_d}/lib
    source_bash_dir ${local_bashrc_d}
  fi
}

edc_main() {
  local edc_home
  local local_edc_home
  local aliases_home
  local bashrc_d
  local bin_home
  local lib_home
  edc_setup_vars
  edc_setup_paths
  edc_export_bash_vars
  edc_source_post_hooks
}

##====|  Execute  |==========================================================##

#skip_edc_bashrc=skip
#shopt -q login_shell && skip_edc_bashrc="Login shell"
[[ $- == *i* ]] || skip_edc_bashrc="Not interactive"

##|  Does some external process want these guts to be skipped?
if [[ -z ${skip_edc_bashrc+x} ]] && [[ "${PS1:-}" != "SPOOFED" ]]; then
  edc_main
else
  echo -n "Skipped EDC bashrc because "
  if [[ -z ${skip_edc_bashrc+x} ]]; then
    echo "PS1=[${PS1:-}]"
  else
    echo "\$skip_edc_bashrc=[${skip_edc_bashrc:-}]"
  fi
fi


###|  EDC ~/.bashrc
 ##|  
 ##|  See:  https://github.com/nwinant/dot-configs
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

edc_setup_home() {
  export edc_home=${default_edc_home:-~/.edc.d}
  export edc_home_local=${default_edc_home_local:-$edc_home/local}
  ##|  Source pre-hook:
  safely_source "$edc_home_local/bashrc-pre-hook"
}

edc_setup_vars() {
  #log_timestamp_format='%Y%m%d-%H:%M:%S'
  log_script_name=" [$( basename ${BASH_SOURCE[0]} )]"

  export platform=$( determine_platform )
  export user_full_name=${USER}

  #export bashrc_d=${default_bashrc_d:-$edc_home/bashrc.d}
  export bashrc_d=${default_bashrc_d:-~/.bashrc.d}
  export bashrc_d_local=${default_bashrc_d_local:-$bashrc_d/local}
  export bashrc_local=${default_bashrc_local:-$edc_home_local/bashrc}

  export bin_home=${default_bin_home:-~/bin}

  export aliases_home=${default_aliases_home:-~/aliases}
  export aliases_home_local=${default_aliases_home_local:-${aliases_home}/local}

  export scripts_home=${default_scripts_home:-~/scripts}
  export scripts_home_local=${default_scripts_home_local:-${scripts_home}/local}

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
  local -r os_dir="$platform"

}

edc_setup_paths() {
  local -r os_dir="$platform"

  ##|  Read local bashrc, if present, allowing config vars to be overridden
   #|  before making it into the PATH:
  safely_source "${bashrc_local}"

  #PATH=${scripts_home}:${scripts_home}/aliases:${bashrc_d}/bin:${bashrc_d}/aliases:${bin_home}:$PATH

  #PATH=${bashrc_d}/bin:$PATH

  ##|  Add platform-specific dirs to PATH, if any:
  #if [ "$PLATFORM" != "unknown" ]; then
  #  prepend_dir_to_path "${bashrc_d}/bin/${os_dir}"
  #fi

  #PATH=$scripts_home:$aliases_home:$bashrc_d_local/bin:$PATH
  PATH=$scripts_home:$aliases_home:$PATH

  if [ "$platform" != "unknown" ]; then
    prepend_dir_to_path "${aliases_home}/${os_dir}"
    prepend_dir_to_path "${scripts_home}/${os_dir}"
  fi

  ##|  Add local script & bin paths:
  PATH=$scripts_home_local:$aliases_home_local:$bin_home:$PATH
}

edc_export_bash_vars() {
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

  source ${scripts_home}/lib/ansi-codes.sh
  source_bash_dir ${bashrc_d}/lib
  source_bash_dir ${bashrc_d}

  ##|  Source platform-specific files, if any
  if [ "$platform" != "unknown" ]; then
    source_bash_dir ${bashrc_d}/lib/${os_dir}
    source_bash_dir ${bashrc_d}/${os_dir}
  fi

  ##|  Source local files, if any
  if [ -d "${bashrc_d_local}" ]; then
    source_bash_dir ${bashrc_d_local}/lib
    source_bash_dir ${bashrc_d_local}
  fi
}

edc_main() {
  edc_setup_home
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


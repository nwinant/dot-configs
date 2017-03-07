###  _____________________________________________________________________________________________ 
### ||                                                                                           ||
### ||__________[[  - EDC ~/.bashrc -  ]]________________________________________________________||
### ||                                                                                           ||
### ||   
### ||    See:  https://github.com/nwinant/dot-configs
### ||   
### ||   
### ||   
### ||___________________________________________________________________________________________||




##  [====[  <<<BEGIN>>> ... IF-SKIP_EDC_BASHRC  ]================================================]

#SKIP_EDC_BASHRC=skip
shopt -q login_shell && SKIP_EDC_BASHRC="Login shell"
[[ $- == *i* ]] || SKIP_EDC_BASHRC="Not interactive"

###  >>>BEGIN<<< IF-SKIP_EDC_BASHRC ... 
 ##
 ##  I.e., does some external process want these guts to be skipped?
if [[ -z ${SKIP_EDC_BASHRC+x} ]] && [[ "${PS1:-}" != "SPOOFED" ]]; then
  ## NOTE: We don't indent the rest of the file, because that would be a giant
  ##       gross hassle...


##  [====[  FUNCTIONS  ]=========================================================================]

source_file() {
  local file=$1
  if [ -f "${file}" ]; then
    #echo "Sourcing $file"
    source $file
  #else echo "Could not source $file"
  fi
}

source_bash_dir() {
  local dir=$1
  for file in $(ls $dir/*.{sh,bash} 2>/dev/null); do
  #for file in $(ls $dir/*.{sh,bash}); do
    #[ -x "$file" ] || continue   # skip non-executable files
    #echo "Sourcing $file"
    source $file
  done
}

# Add directory to PATH if it exists.
add_path_dir() {
  local dir=$1
  if [ -d "${dir}" ]; then
    PATH=${dir}:$PATH
  fi
}


##  [====[  EDC CONFIG VARS  ]===================================================================]

export EDC_HOME=${DEFAULT_EDC_HOME:-~/.edc.d}
export EDC_HOME_LOCAL=${DEFAULT_EDC_HOME_LOCAL:-$EDC_HOME/local}

##  Run pre-hooks...
source_file "$EDC_HOME_LOCAL/bashrc-pre-hook"

#export BASHRC_D=${DEFAULT_BASHRC_D:-$EDC_HOME/bashrc.d}
export BASHRC_D=${DEFAULT_BASHRC_D:-~/.bashrc.d}
export BASHRC_D_LOCAL=${DEFAULT_BASHRC_D_LOCAL:-$BASHRC_D/local}
export BASHRC_LOCAL=${DEFAULT_BASHRC_LOCAL:-$EDC_HOME_LOCAL/bashrc}

export BIN_HOME=${DEFAULT_BIN_HOME:-~/bin}

export ALIASES_HOME=${DEFAULT_ALIASES_HOME:-~/aliases}
export ALIASES_HOME_LOCAL=${DEFAULT_ALIASES_HOME_LOCAL:-${ALIASES_HOME}/local}

export SCRIPTS_HOME=${DEFAULT_SCRIPTS_HOME:-~/scripts}
export SCRIPTS_HOME_LOCAL=${DEFAULT_SCRIPTS_HOME_LOCAL:-${SCRIPTS_HOME}/local}

PLATFORM='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  PLATFORM="linux"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  PLATFORM="freebsd"
elif [[ "$unamestr" == 'Darwin' ]]; then
  PLATFORM="osx"
else
  PLATFORM=""
fi
OS_DIR="$PLATFORM"


##  [====[  VARS  ]==============================================================================]

#export INPUTRC=~/.inputrc
#export INPUTRC=/etc/inputrc
export EDITOR=emacs
export SVN_EDITOR=vim
export BROWSER=google-chrome
export HISTIGNORE="ls:pwd:clear:history:h"
export HISTTIMEFORMAT='| %Y-%m-%d %H:%M:%S |  '
export HISTSIZE=40000
export HISTFILESIZE=$(($HISTSIZE * 10))
#export HISTCONTROL="erasedups:ignorespace"


##  [====[  PATHS  ]=============================================================================]

export CDPATH=.

# Read local bashrc, if present, allowing config vars to be overridden before 
# making it into the PATH
source_file "${BASHRC_LOCAL}"

#PATH=$SCRIPTS_HOME:$SCRIPTS_HOME/aliases:$BASHRC_D/bin:$BASHRC_D/aliases:$BIN_HOME:$PATH

#PATH=$BASHRC_D/bin:$PATH

# Add platform-specific dirs to PATH, if any
#if [ "$PLATFORM" != "unknown" ]; then
#  add_path_dir "${BASHRC_D}/bin/${OS_DIR}"
#fi

#PATH=$SCRIPTS_HOME:$ALIASES_HOME:$BASHRC_D_LOCAL/bin:$PATH
PATH=$SCRIPTS_HOME:$ALIASES_HOME:$PATH

if [ "$PLATFORM" != "unknown" ]; then
  add_path_dir "${ALIASES_HOME}/${OS_DIR}"
  add_path_dir "${SCRIPTS_HOME}/${OS_DIR}"
fi

# Add local script & bin paths
PATH=$SCRIPTS_HOME_LOCAL:$ALIASES_HOME_LOCAL:$BIN_HOME:$PATH

export PATH


##  [====[  SOURCE EXTERNAL CONFIGS  ]===========================================================]

##  Attempt to source bash_completion for git (used for PS1)
if [[ $PS1 ]]; then
  source_file /usr/share/bash-completion/bash_completion
  #source_file /usr/local/etc/bash_completion.d/git-completion.bash
  #source_file /usr/local/git/contrib/completion/git-completion.bash
  source_file /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
  source_file /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
fi

source ${SCRIPTS_HOME}/lib/ansi-codes.sh
source_bash_dir ${BASHRC_D}/lib
source_bash_dir ${BASHRC_D}

# Source platform-specific files, if any
if [ "$PLATFORM" != "unknown" ]; then
  source_bash_dir ${BASHRC_D}/lib/${OS_DIR}
  source_bash_dir ${BASHRC_D}/${OS_DIR}
fi

# Source local files, if any
if [ -d "${BASHRC_D_LOCAL}" ]; then
  source_bash_dir ${BASHRC_D_LOCAL}/lib
  source_bash_dir ${BASHRC_D_LOCAL}
fi


##  [====[  >>>END<<< ... IF-SKIP_EDC_BASHRC  ]==================================================]

## Wherein we close the if-block that started this file:
else
  echo -n "Skipped EDC bashrc because "
  if [[ -z ${SKIP_EDC_BASHRC+x} ]]; then
    echo "PS1=[${PS1:-}]"
  else
    echo "SKIP_EDC_BASHRC=[${SKIP_EDC_BASHRC:-}]"
  fi
fi




### ||                                                                                           ||
### ||___________________________________________________________________________________________||
### ||__________[[  - END -  ]]__________________________________________________________________||



# ==========  DOT-CONFIG VARS  ================================================

export DOT_CONFIGS=${DOT_CONFIGS:-~/.$USER.d}
export DOT_CONFIGS_LOCAL=${DOT_CONFIGS_LOCAL:-$DOT_CONFIGS/local}

#export BASHRC_D=${BASHRC_D:-$DOT_CONFIGS/bashrc.d}
export BASHRC_D=${BASHRC_D:-~/.bashrc.d}
export BASHRC_D_LOCAL=${BASHRC_D_LOCAL:-$BASHRC_D/local}
export BASHRC_LOCAL=${BASHRC_LOCAL:-$DOT_CONFIGS_LOCAL/bashrc}

export BIN_HOME=${BIN_HOME:-~/bin}

export SCRIPTS_HOME=${SCRIPTS_HOME:-~/scripts}
export SCRIPTS_HOME_LOCAL=${SCRIPTS_HOME_LOCAL:-${SCRIPTS_HOME}/local}

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  OS_DIR="linux"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  OS_DIR="freebsd"
elif [[ "$unamestr" == 'Darwin' ]]; then
  OS_DIR="osx"
else
  OS_DIR=""
fi


# ==========  VARS  ===========================================================

export EDITOR=emacs
export SVN_EDITOR=vim
export BROWSER=google-chrome
export HISTIGNORE="ls:pwd:clear:history:h"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTSIZE=40000
export HISTFILESIZE=$(($HISTSIZE * 10))
#export HISTCONTROL="erasedups:ignorespace"


# ==========  FUNCTIONS  ======================================================

source_file() {
  local file=$1
  if [ -e "${file}" ]; then
    source $file
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


# ==========  PATHS  ==========================================================

export CDPATH=.

# Read local bashrc, if present, allowing config vars to be overridden before 
# making it into the PATH
source_file "${BASHRC_LOCAL}"

PATH=$SCRIPTS_HOME:$BASHRC_D/bin:$BIN_HOME:$PATH

add_path_dir "${BASHRC_D_LOCAL}/bin"

# Add platform-specific dirs to PATH, if any
if [ "$PLATFORM" != "unknown" ]; then
  add_path_dir "${SCRIPTS_HOME}/${OS_DIR}"
  add_path_dir "${BASHRC_D}/bin/${OS_DIR}"
fi

PATH=$SCRIPTS_HOME_LOCAL:$PATH

export PATH


# ==========  SOURCE EXTERNAL CONFIGS  ========================================

#source_file /usr/local/git/contrib/completion/git-completion.bash
#GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='[\u@mbp \w$(__git_ps1)]\$ '

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




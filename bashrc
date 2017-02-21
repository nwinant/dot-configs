

# ==========  DOT-CONFIG VARS  ================================================

export DOT_CONFIGS=${DOT_CONFIGS:-~/.${USER}.d}
export DOT_CONFIGS_LOCAL=${DOT_CONFIGS_LOCAL:-$DOT_CONFIGS/local}

export BASHRC_D=${BASHRC_D:-~/.bashrc.d}
export BASHRC_D_LOCAL=${BASHRC_D_LOCAL:-${BASHRC_D}/local}
export BASHRC_LOCAL=${BASHRC_LOCAL:-${DOT_CONFIGS_LOCAL}/bashrc}

export BIN_HOME=${BIN_HOME:-~/bin}

export SCRIPTS_HOME=${SCRIPTS_HOME:-~/scripts}
export SCRIPTS_HOME_LOCAL=${SCRIPTS_HOME_LOCAL:-${SCRIPTS_HOME}/local}


# ==========  VARS  ===========================================================

export EDITOR=emacs
export SVN_EDITOR=vim
export BROWSER=google-chrome
export HISTIGNORE="ls:pwd:clear:history:h"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTSIZE=40000
export HISTFILESIZE=$(($HISTSIZE * 10))
#export HISTCONTROL="erasedups:ignorespace"



# ==========  PATHS  ==========================================================

export CDPATH=.

# Read local bashrc, if present, allowing config vars to be overridden before 
# making it into the PATH
if [ -e "${BASHRC_LOCAL}" ]; then
  source ${BASHRC_LOCAL}
fi

PATH=$SCRIPTS_HOME:$($BASHRC_D/bin/dot-config-paths):$BIN_HOME:$PATH

if [ -e "${BASHRC_D_LOCAL}/bin/dot-config-paths" ]; then
  PATH=$($BASHRC_D_LOCAL/bin/dot-config-paths):$PATH
fi

if [ -d "${SCRIPTS_HOME_LOCAL}" ]; then
  PATH=$SCRIPTS_HOME_LOCAL:$PATH
fi

export PATH


# ==========  SOURCE EXTERNAL CONFIGS  ========================================

source_bash_dir() {
  local dir=$1
  for file in $(ls $dir/*.{sh,bash} 2>/dev/null); do
  #for file in $(ls $dir/*.{sh,bash}); do
    #[ -x "$file" ] || continue   # skip non-executable files
    #echo "Sourcing $file"
    source $file
  done
}

source_bash_dir ${BASHRC_D}/lib
source_bash_dir ${BASHRC_D}

if [ -d "${BASHRC_D_LOCAL}" ]; then
  source_bash_dir ${BASHRC_D_LOCAL}/lib
  source_bash_dir ${BASHRC_D_LOCAL}
fi


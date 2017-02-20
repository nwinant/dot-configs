

# ==========  DOT-CONFIG VARS  ================================================

export BASHRC_D=~/.bashrc.d

BIN_DIR=~/bin

SCRIPTS_HOME=~/scripts
#export SCRIPTS_HOME

#SCRIPTS_LOCAL_HOME=~/scripts/local


# ==========  VARS  ===========================================================

export EDITOR=emacs
export SVN_EDITOR=vim
export BROWSER=google-chrome
export HISTIGNORE="ls:pwd:clear:history:h"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTSIZE=40000
export HISTFILESIZE=$(($HISTSIZE * 10))
#export HISTCONTROL="erasedups:ignorespace"


# ==========  SOURCE EXTERNAL CONFIGS  ========================================

source_bash_dir() {
  local dir=$1
  for file in $(ls $dir/*.{sh,bash} 2>/dev/null); do
    #[ -x "$file" ] || continue   # skip non-executable files
    #echo "Sourcing $file"
    source $file
  done
}

source_bash_dir ~/.bashrc.d/lib
source_bash_dir ~/.bashrc.d


# ==========  PATHS  ==========================================================

export CDPATH=.

PATH=$SCRIPTS_HOME:$($BASHRC_D/bin/dot-config-paths):$BIN_DIR:$PATH

export PATH



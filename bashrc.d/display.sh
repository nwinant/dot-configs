#!/usr/bin/env bash


###|  PROMPTS
###==========

get_term_title() {
  export PREVIOUS_COMMAND="$(sed -e 's/[[:space:]]*$//' <<<$(fc -nl -0))"
  echo -en "\033]0;$("term-title")\a"
}

case "$TERM" in
xterm*|rxvt*)
  #PROMPT_COMMAND='echo -en "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
  PROMPT_COMMAND='echo -en "$(get_term_title)"'
  ;;
esac

#COLOR1=$BROWN
#BG_COLOR=${BG_BLACK}
BG_COLOR=${BG_DEFAULT}
COLOR1="\[\033[${ATTR_NONE};${FG_YELLOW};${BG_COLOR}m\]"

##   https://gist.github.com/trey/2722934
GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='[\u@mbp \w$(__git_ps1)]\$ '
#YELLOW="\[$(tput setaf 3)\]"
#RESET="\[$(tput sgr0)\]"
#PS1="\h:\W \u\$(__git_ps1 \" ${YELLOW}(%s)${RESET} \")\$ "
#GIT_COLOR="\[\033[${ATTR_NONE};${FG_GREEN};${BG_COLOR}m\]"
GIT_COLOR="\[$(tput setaf $TPUT_GREEN)\]"

if [ `whoami` = "root" ]
then
  COLOR1=$RED
fi
#COLOR2=$GRAY
COLOR2="\[\033[${ATTR_NONE};${FG_WHITE};${BG_COLOR}m\]"
#export PS1="${COLOR1}\!${COLOR2} \D{%m-%d} \t ${COLOR1}\w:${NO_COLOR} "
export PROMPT_DIRTRIM=3
export PS1_DIRTRIM=3

GIT_PS1=""
if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" = function ]; then 
  #GIT_PS1="\$(__git_ps1 \" ${ORANGE}(%s)${RESET}\")"
  GIT_PS1="\$(__git_ps1 \" ${GIT_COLOR}(%s)${NO_COLOR}\")"
fi

#export PS1="${COLOR1}\!${COLOR2} \t ${COLOR1}\w:${NO_COLOR} "
#export PS1="${COLOR1}\!${COLOR2} \t ${COLOR1}\w\$(__git_ps1 \" ${YELLOW}(%s)${RESET}\"):${NO_COLOR} "
export PS1="${COLOR1}\!${COLOR2} \t ${COLOR1}\w${NO_COLOR}${GIT_PS1}${COLOR1}:${NO_COLOR} "


###|  LS & grep
###============

##|  OS X & FreeBSD only
##|  See http://unix.stackexchange.com/questions/2897/clicolor-and-ls-colors-in-bash
setup_ls_colors_bsd () {
  export CLICOLOR=1
}

##|  See http://man7.org/linux/man-pages/man5/dir_colors.5.html
setup_ls_colors_linux () {
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="tw=40:ow=1;34;40"  ##|  Ensures directory colors are not-obnoxious
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
}

if [[ "$platform" == 'osx' ]]; then
  setup_ls_colors_bsd 
elif [[ "$platform" == 'freebsd' ]]; then
  setup_ls_colors_bsd
elif [[ "$platform" == 'linux' ]]; then
  setup_ls_colors_linux
fi


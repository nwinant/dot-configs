#!/usr/bin/env bash


##    PROMPTS
##===========

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

if [ `whoami` = "root" ]
then
        COLOR1=$RED
fi
#COLOR2=$GRAY
COLOR2="\[\033[${ATTR_NONE};${FG_WHITE};${BG_COLOR}m\]"
#export PS1="${COLOR1}\!${COLOR2} \D{%m-%d} \t ${COLOR1}\w:${NO_COLOR} "
export PROMPT_DIRTRIM=3
export PS1_DIRTRIM=3
#export PS1="${COLOR1}\!${COLOR2} \t ${COLOR1}\w:${NO_COLOR} "
export PS1="${COLOR1}\!${COLOR2} \t ${COLOR1}\$(trimmed-pwd):${NO_COLOR} "



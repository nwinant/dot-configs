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


###|  ls & grep
###============

##|  GNU Linux colors
 #|  
 #|  See: http://man7.org/linux/man-pages/man5/dir_colors.5.html
 #|       http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
 #|       https://www.gnu.org/software/coreutils/manual/html_node/General-output-formatting.html
 ##
setup_ls_colors_linux () {
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #export LS_COLORS="tw=40:ow=1;34;40:ln=target"  ##|  Ensures directory colors are not-obnoxious
    local -r di="40"  ##|  Ensures directory colors are not-obnoxious
    export LS_COLORS="di=${di}:tw=${di}:ow=1;34;${di}:ln=target"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
}

##|  OS X / BSD / FreeBSD colors
 #|  
 #|  See: http://unix.stackexchange.com/questions/2897/clicolor-and-ls-colors-in-bash
 #|       http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
 #|       https://superuser.com/questions/416835/how-can-i-grep-with-color-in-mac-os-xs-terminal
 ##
setup_ls_colors_bsd () {
  ##    a black
  ##    b red
  ##    c green
  ##    d brown
  ##    e blue
  ##    f magenta
  ##    g cyan
  ##    h light grey
  ##    A bold black, usually shows up as dark grey
  ##    B bold red
  ##    C bold green
  ##    D bold brown, usually shows up as yellow
  ##    E bold blue
  ##    F bold magenta
  ##    G bold cyan
  ##    H bold light grey; looks like bright white
  ##    x default foreground or background
  ##
  ## Defaults: export LSCOLORS="exfxcxdxbxegedabagacad"
  ##                            ex fx cx dx bx eg ed ab ag ac ad
  ##    di = ex     1. directory
  ##    ln = fx     2. symbolic link
  ##    so = cx     3. socket
  ##    pi = dx     4. pipe
  ##    ex = bx     5. executable
  ##    bd = eg     6. block special
  ##    cd = ed     7. character special
  ##       = ab     8. executable with setuid bit set (su u+s SETUID?)
  ##       = ag     9. executable with setgid bit set (sg g+s SETGID?)
  ##    tw = ac    10. directory writable to others, with sticky bit (+t,o+w)
  ##    ow = ad    11. directory writable to others, without sticky bit (o+w) 
  local -r di="Ex"     ##  ex
  local -r ln="fx"     ##  fx
  local -r ex="Cx"     ##  bx
  local -r tw="ac"     ##  ac
  local -r ow="ad"     ##  ad
  export LSCOLORS="${di}${ln}cxdx${ex}egedabag${tw}${ow}"
  export CLICOLOR=1
  export GREP_OPTIONS='--color=always'
  #export GREP_COLOR='1;35;40'
}

if   [[ "$platform" == 'linux'   ]] ; then setup_ls_colors_linux
elif [[ "$platform" == 'osx'     ]] ; then setup_ls_colors_bsd 
elif [[ "$platform" == 'freebsd' ]] ; then setup_ls_colors_bsd
fi


# Copyright (C) 2022  HimbeerserverDE
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

if [[ "${USER_ALIAS}" == "" ]]; then
	USER_ALIAS=${USER}
fi

function theme_precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""

    if [[ "${USER_ALIAS}" == "" ]]; then
      	USER_ALIAS=${USER}
    fi

    if [[ "${USER_ALIAS_LENGTH}" == "" ]]; then
		USER_ALIAS_LENGTH=${#${USER_ALIAS}}
    fi

    local promptsize=${#${(%):-------[@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}

    if [[ "${promptsize} + ${pwdsize}" -gt ${TERMWIDTH} ]]; then
      ((PR_PWDLEN=${TERMWIDTH} - ${promptsize}))
    else
      PR_FILLBAR="\${(l.((${TERMWIDTH} - (${promptsize} + ${USER_ALIAS_LENGTH} + ${pwdsize})))..${PR_HBAR}.)}"
    fi

}


setopt extended_glob
theme_preexec () {
    if [[ "${TERM}" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek${CMD}\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst

    ###
    # See if we can use colors.

    autoload zsh/terminfo
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
	eval PR_$color='%{${terminfo[bold]}${fg[${(L)color}]}%}'
	eval PR_LIGHT_$color='%{${terminfo[bold]}${fg[${(L)color}]}%}'
	(( count = ${count} + 1 ))
    done
    PR_NO_COLOUR="%{${terminfo[sgr0]}%}"

    ###
    # Modify Git prompt
    ZSH_THEME_GIT_PROMPT_PREFIX=" ${PR_BLUE}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="%{${fg[green]}%} +"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{${fg[yellow]}%} 🚧"
    ZSH_THEME_GIT_PROMPT_DELETED="%{${fg[red]}%} -"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{${fg[magenta]}%} ➔"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{${fg[blue]}%} ∩"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${fg[cyan]}%} 📹"

    ###
    # See if we can use extended characters to look nicer.
    # UTF-8 Fixed

    if [[ $(locale charmap) == "UTF-8" ]]; then
	PR_SET_CHARSET=""
	PR_SHIFT_IN=""
	PR_SHIFT_OUT=""
	PR_HBAR="━"
        PR_ULCORNER="┏"
        PR_LLCORNER="┗"
        PR_LRCORNER="┛"
        PR_URCORNER="┓"
    else
        typeset -A altchar
        set -A altchar ${(s..)terminfo[acsc]}
        # Some stuff to help us draw nice lines
        PR_SET_CHARSET="%{${terminfo[enacs]}%}"
        PR_SHIFT_IN="%{${terminfo[smacs]}%}"
        PR_SHIFT_OUT="%{${terminfo[rmacs]}%}"
        PR_HBAR='${PR_SHIFT_IN}${altchar[q]:--}${PR_SHIFT_OUT}'
        PR_ULCORNER='${PR_SHIFT_IN}${altchar[l]:--}${PR_SHIFT_OUT}'
        PR_LLCORNER='${PR_SHIFT_IN}${altchar[m]:--}${PR_SHIFT_OUT}'
        PR_LRCORNER='${PR_SHIFT_IN}${altchar[j]:--}${PR_SHIFT_OUT}'
        PR_URCORNER='${PR_SHIFT_IN}${altchar[k]:--}${PR_SHIFT_OUT}'
     fi


    ###
    # Decide if we need to set titlebar text.

    #case $TERM in
	#xterm*)
	#   PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	#    ;;
	#screen)
	#    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	#    ;;
	#*)
	#    PR_TITLEBAR=''
	#    ;;
    #esac

	PR_TITLEBAR=$'%{\e]0;zsh\a%}'

    ###
    # Decide whether to set a screen title
    if [[ "${TERM}" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi

	###
	# Use a different prompt character for root.
	if [[ "${UID}" == "0" ]]; then
	PR_CHAR='#'
	else
	PR_CHAR='⊳'
	fi

    ###
    # Finally, the prompt.

    PROMPT='${PR_SET_CHARSET}${PR_STITLE}${(e)PR_TITLEBAR}\
${PR_CYAN}${PR_ULCORNER}${PR_HBAR} [ ${PR_BLUE}${HOST} \
${PR_MAGENTA}%${PR_PWDLEN}<...<%~%<< ${PR_CYAN}] \

${PR_CYAN}${PR_LLCORNER}${PR_HBAR}%{${reset_color}%}`git_prompt_info``git_prompt_status`\
${PR_CYAN} ${PR_CHAR} ${PR_NO_COLOUR}'

    # display exitcode on the right when >0
    return_code="%(?..%{${fg[red]}%}%? ↵%{${reset_color}%})"
    RPROMPT=' ${return_code}${PR_NO_COLOUR}'

    PS2='${PR_BLUE}${PR_HBAR}\
${PR_BLUE}${PR_HBAR}(\
${PR_LIGHT_GREEN}%_${PR_BLUE})${PR_HBAR}\
${PR_CYAN}${PR_HBAR}${PR_NO_COLOUR} '
}

setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
add-zsh-hook preexec theme_preexec

fortune | cowsay | lolcat -S 23
echo
neofetch

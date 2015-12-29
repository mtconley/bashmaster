#!/bin/bash
color_my_prompt() {
    #local __user_and_host="\[\033[01;32m\]\u@\h"

    marker=$'\033[38;5;229m\xe2\x96\xb6\x20'
    cwd="${PWD##*/root}"
    cwdpath_below="$marker$cwd"
    cwdpath_above="\[\033[38;5;229m\]\w"
    PWD | grep -q '/root' && text=$cwdpath_below || text=$cwdpath_above
    local __cur_location=$text
    local __git_branch_color="\[\033[1;96m\]"
    local __git_branch="`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`"
    local __prompt_tail="\[\033[38;5;123m\]\\$:" # prompt color and symbol
    local __last_color="\[\033[0m\]" # command color
    export PS1="$__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

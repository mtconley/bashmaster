#!/bin/bash
color_my_prompt() {
    #local __user_and_host="\[\033[01;32m\]\u@\h"

    marker=$'\xe2\x96\xb6\x20'
    cwd_root="${PWD##*/root}"
    cwd_home="\w"
    cwdpath_below="$marker$cwd_root"
    cwdpath_above="$cwd_home"
    PWD | grep -q '/root' && text=$cwdpath_below || text=$cwdpath_above
    local __cur_location="\[\033[38;5;229m\]$text"
    local __git_branch_color="\[\033[1;96m\]"
    # __git_branch must have command wrapped in single quotes to update on checkout...
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[38;5;123m\]\\$:" # prompt color and symbol
    local __last_color="\[\033[0m\]" # command color
    export PS1="$__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

#!/bin/bash
color_my_prompt() {
    #local __user_and_host="\[\033[01;32m\]\u@\h"

    marker=$'\xe2\x96\xb6\x20'
    cwd_root="${PWD##*/root}"
    cwd_home="\w"
    cwdpath_below="$marker$cwd_root"
    cwdpath_above="$cwd_home"
    PWD | grep -q '/root' && loc_text=$cwdpath_below || loc_text=$cwdpath_above

    local __cur_location_color="\[\033[38;5;229m\]"
    local __cur_location_text="$loc_text"
    local __cur_location=$__cur_location_color$__cur_location_text

    # __git_branch must have command wrapped in single quotes to update on checkout...
    local __git_branch_color="\[\033[1;96m\]"
    local __git_branch_text='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __git_branch=$__git_branch_color$__git_branch_text

    local __prompt_tail_color="\[\033[38;5;123m\]"
    local __prompt_tail_text="\\$:" # prompt color and symbol
    local __prompt_tail=$__prompt_tail_color$__prompt_tail_text

    local __last_color="\[\033[0m\]" # command color
    export PS1="$__cur_location $__git_branch$__prompt_tail$__last_color "
}

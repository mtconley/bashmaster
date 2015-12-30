#!/bin/bash
color_my_prompt ()
{
    local __cur_locn_c="\[\033[38;5;124m\]";
    local __cur_locn="\w";
    local __git_branch_c="\[\033[38;5;22m\]";
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`';
    local __prompt_tail_c="\[\033[36m\]";
    local __prompt_tail="⚙";          # or any other cool unicode symbol i.e. ><(((º> 
    local __input_c="\[\033[00m\]";
    export PS1="$__cur_locn_c$__cur_locn $__git_branch_c$__git_branch$__prompt_tail_c$__prompt_tail$__input_c "
}

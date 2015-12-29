function funcs {
    if [ -z "$@" ]; then
        typeset -F | sed 's/declare -f//'
    else
        typeset -f $@ | pygments bash
    fi
}

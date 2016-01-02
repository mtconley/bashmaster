#!/bin/bash
pyc() {
# pipe values to python in commmand line
# usage: ls | pyc files "files=map(lambda x: x.upper(), files.split())"
# Main variable '_a_r_g_' chosen to avoid collision with $1
    case $1 in
        -h | --help)
            cat <<- ---
            usage: pyc
                pyc <object name> <python script>
            EXAMPLES
                ls | pyc files "files=map(lambda x: x.upper(), files.split())"
                ls | pyc args "len(args.split())"
            ---
        ;;
    esac
    script="
from pprint import pprint
import sys
_a_r_g_=sys.argv[1]
exec(_a_r_g_ + '= sys.stdin.read()')
exec(\"$2\")
pprint(eval(_a_r_g_))"
    response=`python -c "$script" $1`;
    echo -e $response
}

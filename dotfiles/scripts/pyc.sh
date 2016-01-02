#!/bin/bash
pyc() {
# pipe values to python in commmand line
# usage: ls | pyc files "files=map(lambda x: x.upper(), files.split())"
# Main variable '_a_r_g_' chosen to avoid collision with $1
    case $1 in
        -h | --help)
            help_text="
            \r\nusage: pyc\n
                \tpyc <object name> <python script>\n
            EXAMPLES\n
                \tls | pyc files \"files=map(lambda x: x.upper(), files.split())\"\n
                \tls | pyc args \"args=len(args.split())\"\n"
            echo -e $help_text
        ;;
        *)
            script="
from pprint import pprint
import sys
_a_r_g_=sys.argv[1]
exec(_a_r_g_ + '= sys.stdin.read()')
exec(\"$2\")
pprint(eval(_a_r_g_))"
            response=`python -c "$script" $1`;
            echo -e $response
        ;;
    esac
}

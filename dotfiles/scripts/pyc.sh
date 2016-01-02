#!/bin/bash
pyc() {
# pipe values to python in commmand line
# usage: ls | pyc files "files=map(lambda x: x.upper(), files.split())"
    script="import sys
arg=sys.argv[1]
exec(arg + '= sys.stdin.read()')
exec(\"$2\")
print eval(arg)"
    python -c "$script" $1;
}

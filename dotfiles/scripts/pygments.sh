#!/bin/bash
# Add pygments through pip install pygments
pygments(){
    if [ $# -gt 0 ]; then
        has_lexer=`echo "$1" | grep -Eq "^xml$|^html$|^csv$|^json$|^numpy$|^bash$" && echo true || echo false`
        if [ $has_lexer == "true" ]; then
            command pygmentize -l $1 -O style="monokai" -f console256 -g
        
        else
            command pygmentize -O style="monokai" -f console256 -g $@
        fi

    fi

}
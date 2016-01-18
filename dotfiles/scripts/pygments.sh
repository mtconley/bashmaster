#!/bin/bash
# Add pygments through pip install pygments
filetypes="xml
           html
           csv
           json
           numpy
           bash
           md"

pattern_join(){
    echo $@ | tr ' ' '\n' | sed 's/\(.*\)/^\1$/g' | tr '\n' '|' | rev | cut -c 2- | rev
}


function pygments(){
    pattern=`pattern_join $filetypes`
    if [ $# -gt 0 ]; then
        has_lexer=`echo "$1" | grep -Eq $pattern && echo true || echo false`
        
        if [ $has_lexer == "true" ]; then
            command pygmentize -l $1 -O style="monokai" -f console256 -g ${@:2}
        
        else
            command pygmentize -O style="monokai" -f console256 -g $@
        fi

    fi

}


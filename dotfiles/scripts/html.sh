#!/bin/bash

html () {

    FLAG=$1
    FILENAME="$2"

    if [[ $# = 1 ]] && [[ -f $FLAG ]]; then
        FILENAME="$FLAG"
        FLAG="-f"
    elif [[ $# = 0 ]]; then
        FLAG="-f"
    fi

    case $FLAG in
        -f | --format)
            # tidy-html5 install from https://github.com/htacg/tidy-html
            # Must pipe file or tidy will overwrite to conform with html standard
            # pygments is a wrapper for pygments:pygmentize -- pip install pygments
            parse="tidy -i -q 2> /dev/null | pygments html"
        ;;
        -r | --render)
            # hermit install using `sudo npm hermit`    
            # must pipe file through sed because hermit cannot parse linebreaks
            parse="sed 's/<br>/,/g' | hermit"
        ;;
        -h | --help)
            HELP_TEXT="usage: html [-rf] [file]
            \roptions:
            \r    -f, --format    format html file for easy reading    
            \r    -r, --render    render html file in terminal"
            echo -e "$HELP_TEXT"
            return 0
        ;;
        *)
            echo "ERROR: Argument, $FLAG, not recognized"
            return 1
        ;;
    esac

    if [[ -n ${FILENAME} ]]; then
        COMMAND="cat ${FILENAME} | ${parse}"
    else
        COMMAND=${parse}
    fi
    eval  $COMMAND
}

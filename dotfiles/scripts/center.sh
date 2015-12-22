#!/bin/bash
center() {
    columns=$width
    text=""
    while IFS= read -r line; do
        text="$text`repeatstr ' ' $(max 0 $(( (columns - ${#line}) / 2 )) )`$line\n"
    done
    printf "$text"
}

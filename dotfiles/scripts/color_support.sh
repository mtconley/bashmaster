
# Colors
color() {
    export $1=`echo -e "\033[$2m"`
    alias $1="echo \$$1"
}

color black '0;30'
color red '0;31'
color green '0;32'
color yellow '0;33'
color blue '0;34'
color magenta '0;35'
color cyan '0;36'
color white '0;37'
color BLACK '1;30'
color RED '1;31'
color GREEN '1;32'
color YELLOW '1;33'
color BLUE '1;34'
color MAGENTA '1;35'
color CYAN '1;36'
color WHITE '1;37'
color endcolor ''

alias ct='colortable'
colortable() {
    for fgbg in 38 48 ; {
        for color in {0..256} ; {
            echo -en "\033[${fgbg};5;${color}m ${color}\t\033[0m"
            [[ $((($color + 1) % 10)) == 0 ]] && echo
        }
        echo
    }
}

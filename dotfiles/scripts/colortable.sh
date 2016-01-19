colortable() {
    for fgbg in 38 48 ; {
        for color in {0..256} ; {
            echo -en "\033[${fgbg};5;${color}m ${color}\t\033[0m"
            [[ $((($color + 1) % 10)) == 0 ]] && echo
        }
        echo
    }
}
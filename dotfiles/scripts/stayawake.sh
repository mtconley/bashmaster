stayawake(){
    if [ `pgrep caffeinate | wc -l` -eq 0 ]; then
        command caffeinate -u -t 600 &
    fi
}
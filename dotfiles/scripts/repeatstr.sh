repeatstr() {
    printf "$1%.0s" `seq 1 $2`
}

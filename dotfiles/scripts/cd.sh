cd() {
    if [[ $@ == "last" ]]; then
        command cd `ls -1tq | head -n 1`
    elif [[ $@ == "second" ]]; then
        command cd `ls -1qt | head -n 2 | tail -n 1`
    else
        command cd "$@"
    fi
}
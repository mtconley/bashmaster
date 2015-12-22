source() {
    if [[ $@ == "bp" ]]; then
        command source ~/.bash_profile
    else
        command source $@
    fi
}
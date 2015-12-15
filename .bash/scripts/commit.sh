commit() {
    command git commit -a -m $@
    command git push
}
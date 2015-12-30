
# Colors
color() {
    export $1=`echo -e "\033[$2m"`
    alias $1="echo \$$1"
}
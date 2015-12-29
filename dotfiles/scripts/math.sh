sum() { # option + w
    [[ $# -eq 0 ]] && cat | awk '{ s+=$1 } END { print s }' || \
    [[ $# -eq 1 ]] && awk '{ s+=$1 } END { print s }' $1 || \
    sed 's| | \+ |g' <<< "$@" | bc
}

product() { # option + p
    [[ $# -eq 0 ]] && cat | awk '{ s*=$1 } END { print s }' || \
    [[ $# -eq 1 ]] && awk '{ s*=$1 } END { print s }' $1 || \
    sed 's| | \* |g' <<< "$@" | bc
}

factorial() { 
    (echo 1; seq $1) | paste -s -d '\*' - | bc
}

max() {
    [ $1 -gt $2 ] && echo $1 || echo $2
}

min() {
    [ $1 -lt $2 ] && echo $1 || echo $2
}


# Sets
union() {
    sort -u $1 $2
}

difference() {
    sort $1 $2 | uniq -u
}

intersection() {
    sort $1 $2 | uniq -d
}


complement() {
    comm -23 <(sort $1) <(sort $2)
}


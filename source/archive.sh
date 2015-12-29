#!/bin/bash
archive_profile(){
    now=`date +"%Y%m%d"`
    cp ~/.bash_profile $"../archive/bash_profile_$now"
}

last(){
    ls -1tq $1 | head -n $2 | tail -n 1
}

complement ()
{
    comm -23 <(sort $1) <(sort $2)
}

isnew(){
    bash_archive=`last ../archive 1`
    bash_current=~/.bash_profile
    diff=`complement $bash_archive $bash_current | wc -l`
    [[ diff -eq 0 ]] && echo false || echo true
}

touch ~/.bash_profile
if [[ isnew -eq  true ]]; then
    archive_profile
fi

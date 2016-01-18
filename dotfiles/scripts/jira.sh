#!/bin/bash

ifstr() {
    if [[ -n "$1" ]]; then
        return 0
    else
        return 1    
    fi
}


jira-new (){
    SUBJECT=$1
    PRIORITY=`ifstr($2) || 5`
    USERNAME=`ifstr($3) || grep username ~/.jira-cli/config.cfg | sed 's/username = //'`
    case $PRIORITY in
        1)
            PRIORITY=P1-Critical
        ;;
        2)
            PRIORITY=P2-High
        ;;
        3)
            PRIORITY=P3-Medium
        ;;
        4)
            PRIORITY=P4-Low            
        ;;
        5)
            PRIORITY=P5-Undetermined
        ;;
    esac 
    
    jira-cli new --type=data --PRIORITY="$PRIORITY" --project="REL" --title="$SUBJECT" --assign="$USERNAME"
}


jira () {
    case $1 in
        new)
            jira-new $2 $3 $4
        ;;
        *)
            jira-cli $@ -v
        ;;
    esac
}

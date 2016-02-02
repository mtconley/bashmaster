#!/bin/bash

ticket () {
    SUBJECT="$1"
    PROJ_NAME=`jira new $SUBJECT -v | grep '^issue' | grep -o 'REL-\d*' | sed 's/-//'`
    `mkproj $PROJ_NAME`
    `cd $PROJ_NAME`
    `domino init`
    `domino sync`
}

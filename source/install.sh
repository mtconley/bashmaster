#!/bin/bash
BASH_DIR=${PWD%/*}
install_new_profile(){
    line1="export BASH_DIR=$BASH_DIR"
    line2=". \$BASH_DIR/dotfiles/.bash_run"
    echo $line1 > ~/.bash_profile
    echo $line2 >> ~/.bash_profile
    . ~/.bash_profile
}

make_new_branch(){
    name=`uname -n`
    git checkout -b $name
}

make_new_branch
echo "1"
bash $BASH_DIR/source/archive.sh
echo "2"
install_new_profile
echo "3"

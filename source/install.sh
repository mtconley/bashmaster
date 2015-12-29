#!/bin/bash
BASH_DIR=${PWD%/*}
install_new_profile(){
    line1="export BASH_DIR=$BASH_DIR"
    line2=". \$BASH_DIR/.bash_run"
    echo $line1 > ~/.bash_profile
    echo $line2 >> ~/.bash_profile
}
bash $BASH_DIR/source/archive.sh
install_new_profile

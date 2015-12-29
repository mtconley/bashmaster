#!/bin/bash
exports() {
    typeset -x | sed 's/declare -x//' | pygmentize -l bash -O style=monokai -f console256 -g
}

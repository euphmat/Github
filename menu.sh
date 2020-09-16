#!/usr/bin/env bash
set -Ceuo pipefail

function main(){
        select_menu
        print_blankline
}

function select_menu(){
    PS3="type Number:"

    select no in pull clone
    do
        case $no in
            $no)
                ./.bin/$no.sh
                break;;
            *)
        esac
    done
}
function print_blankline(){
        echo ""
}
main

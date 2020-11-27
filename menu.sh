#!/usr/bin/env bash
set -Ceuo pipefail

function main(){
        move_src_directory
        create_menu
        select_menu
}

# ./.bin/配下に置かれたシェルスクリプトを配列にぶち込む
function create_menu(){
    files="./.bin/*"
    for filepath in $files
    do
            filepath=`basename $filepath .sh`
            array+=("$filepath") 
    done
}

# create_menu()で作成した配列をメニューとして表示
function select_menu(){
    PS3="type Number:"
    echo ""
    select no in ${array[@]}
    do
        case $no in
            $no)
                ./.bin/$no.sh
                break;;
            *)
        esac
    done
}

function move_src_directory() {
        cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
}
main

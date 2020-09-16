#!/usr/bin/env bash
set -Ceuo pipefail

function main(){
        PS3="type Number:"

        select no in status pull
        do
                case $no in
                        status)
                               ./.bin/status.sh 
                                break
                                ;;
                        pull)
                               ./.bin/pull.sh 
                                break
                                ;;
                        *)
                esac
        done
}

main

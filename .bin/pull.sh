#!/bin/bash

function main(){
        # Github
        # ========================================================
        cd ~/Github
        print blank
        print Github
        pull_current_directory

        # Github 配下
        # ========================================================
        store_repository_name_to_array
        for i in ${dirary[@]}; do
                cd $i
                print Repository
                pull_current_directory
        done
}

function pull_current_directory() {
        if [[ -d ./.git/ ]]; then
                if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
                        print Branch && print Success
                else
                        print Branch && print Failed
                fi
        else
                print Branch && print not_Git_Repository
        fi
}

function print(){
        case $1 in
                "Github" ) echo -en "\033[0;34mGithub\033[0;39m" ;;
                "Repository" ) echo -en "\033[0;34m`echo $i | awk -F '/' '{print $(NF)}'`\033[0;39m" ;;
                "Branch" ) echo -en "`git branch | grep -E "\*" | sed -e "s/\*//"`" ;;
                "Success" ) echo -e " \033[0;32mSuccessfull\033[0;39m" ;;
                "Failed" ) echo -e " \033[0;31mFailed\033[0;39m" ;;
                "not_Git_Repository" ) echo -e " \033[0;33mnotGitRepository\033[0;39m" ;;
                "line" ) echo "========================" ;;
                "blank" ) echo "" ;;
        esac
}

function store_repository_name_to_array() {
        files=~/Github/*
        dirary=()
        for filepath in $files; do
                if [ -d $filepath ] ; then
                        dirary+=("$filepath")
                fi
        done
}

main

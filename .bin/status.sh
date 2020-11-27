#!/bin/bash

function main(){
        # Github
        # ========================================================
        cd ~/Github
        print blank
        print Github
        show_status

        # Github 配下
        # ========================================================
        store_repository_name_to_array
        for i in ${dirary[@]}; do
                cd $i
                print Repository
                show_status
        done
}


function show_status() {
        if [[ -d ./.git/ ]]; then
                #if [[ `git status > /dev/null 2>&1 ; echo $?` = 0 ]]; then
                if [[ `git status --porcelain` ]]; then
                        print Branch && print Changes
                        print line
                        git status --porcelain
                        print blank
                else
                        print Branch && print No_Changes
                        print line
                        print blank
                fi
        else
                print not_Git_Repository
                print line
                print blank
        fi
}

function print(){
        case $1 in
                "Github" ) echo -en "\033[0;34mGithub\033[0;39m" ;;
                "Repository" ) echo -en "\033[0;34m`echo $i | awk -F '/' '{print $(NF)}'`\033[0;39m" ;;
                "Branch" ) echo -en "`git branch | grep -E "\*" | sed -e "s/\*//"`" ;;
                "No_Changes" ) echo -e " \033[0;32mNo_Changes\033[0;39m" ;;
                "Changes" ) echo -e " \033[0;31mChanges\033[0;39m" ;;
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

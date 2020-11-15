#!/bin/bash

function main(){
        # Github管理リポジトリに対して`git pull`
        cd ~/Github
        echoo Github
        pull_current_directory

        # Githubディレクトリ配下のリポジトリに対して`git pull`
        store_repository_name_to_array
        for i in ${dirary[@]}; do
                cd $i
                echoo Repository
                pull_current_directory
        done
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

function pull_current_directory() {
        if [[ -d ./.git/ ]]; then
                if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
                        echoo Branch && echoo Success
                else
                        echoo Branch && echoo Failed
                fi
        else
                echoo Branch && echoo not_Git_Repository
        fi
}

function echoo(){
        case $1 in
                "Github" ) echo -en "\033[0;34mGithub\033[0;39m" ;;
                "Repository" ) echo -en "\033[0;34m`echo $i | awk -F '/' '{print $(NF)}'`\033[0;39m" ;;
                "Branch" ) echo -en "`git branch | grep -E "\*" | sed -e "s/\*//"`" ;;
                "Success" ) echo -e " \033[0;32mSuccessfull\033[0;39m" ;;
                "Failed" ) echo -e " \033[0;31mFailed\033[0;39m" ;;
                "not_Git_Repository" ) echo -e " \033[0;33mnotGitRepository\033[0;39m" ;;
        esac
}

main

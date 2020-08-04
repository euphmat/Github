#!/bin/bash

# ===========================================
# Github Repository Status View
# ===========================================
cd ~/Github
files=~/Github/*
echo -en "\033[0;34mGithub\033[0;39m"
if [[ -d ./.git/ ]]; then
        if [ -z "$(git status --porcelain)" ]; then
                echo -e " : \033[0;32mClean\033[0;39m"
        else
                echo -e " : \033[0;31mUncommitted Changes\033[0;39m"
        fi
fi

# ===========================================
# Github Repository in Repository
# ===========================================
dirary=()
for filepath in $files; do
        if [ -d $filepath ] ; then
                dirary+=("$filepath")
        fi
done


for i in ${dirary[@]}; do
        reponame=`echo $i | awk -F '/' '{print $(NF)}'`
        echo -en "└─\033[0;34m$reponame\033[0;39m" 
        cd $i
        if [[ -d ./.git/ ]]; then
                if [ -z "$(git status --porcelain)" ]; then
                        echo -e " : \033[0;32mClean\033[0;39m"
                else
                        echo -e " : \033[0;31mUncommitted Changes\033[0;39m"
                fi
        else
                echo -e " : \033[0;33mnot Git Repository\033[0;39m"
        fi
done


#!/bin/bash

# Github Directory
files=~/Github/*

dirary=()
for filepath in $files; do
  if [ -d $filepath ] ; then
    dirary+=("$filepath")
  fi
done

echo ""
for i in ${dirary[@]}; do
        reponame=`echo $i | awk -F '/' '{print $(NF)}'`
        echo -en "\033[0;34m$reponame\033[0;39m"
        echo -n "($i)"
        cd $i
        if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
                echo -e " : \033[0;32mSuccessful\033[0;39m"
        else
                echo -e " : \033[0;31mFailed\033[0;39m"
        fi
        cd ../
done

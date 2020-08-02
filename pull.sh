#!/bin/bash

# Github Repository Pull
cd ~/github
git pull

# Github Directory Path
files=~/Github/*

# main
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
  if [[ -d ./.git/ ]]; then
    if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
      echo -e " : \033[0;32mSuccessful\033[0;39m"
    else
      echo -e " : \033[0;31mFailed\033[0;39m"
    fi
  else
    echo -e " : \033[0;33mnot Git Repository\033[0;39m"
  fi

done

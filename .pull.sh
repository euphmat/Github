#!/bin/bash

function main(){
  # Github/
  echo -en "\033[0;34mGithub\033[0;39m" 
  cd ~/Github; 
  all_git_pull

  # Github/*
  get_directory
  for i in ${dirary[@]}; do
    cd $i
    print_repository_name
    all_git_pull
  done
}

function get_directory() {
  files=~/Github/*
  dirary=()
  for filepath in $files; do
    if [ -d $filepath ] ; then
      dirary+=("$filepath")
    fi
  done
}

function print_repository_name(){
  reponame=`echo $i | awk -F '/' '{print $(NF)}'`
  echo -en "\033[0;34m$reponame\033[0;39m" 
}

function all_git_pull() {
  branchname=`git branch | grep -E "\*" | sed -e "s/\*//"`
  if [[ -d ./.git/ ]]; then
    if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
      echo -en "$branchname"
      echo -e " \033[0;32mSuccessfull\033[0;39m"
    else
      echo -en "$branchname"
      echo -e " \033[0;31mFailed\033[0;39m"
    fi
  else
    echo -en "$branchname"
    echo -e " \033[0;33mnotGitRepository\033[0;39m"
  fi
}

main | column -t

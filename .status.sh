#!/usr/bin/env bash
set -Ceuo pipefail

function main(){
  # Github/
  echo -en "\033[0;34mGithub\033[0;39m" 
  cd ~/Github; 
  print_git_status

  # Github/*
  get_directory
  for i in ${dirary[@]}; do
    cd $i
    print_repository_name
    print_git_status
  done
}

function get_directory(){
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

function print_git_status(){
  branchname=`git branch | grep -E "\*" | sed -e "s/\*//"`
  if [[ -d ./.git/ ]]; then
    if [ -z "$(git status --porcelain)" ]; then
      echo -en "$branchname"
      echo -e " \033[0;32mClean\033[0;39m"
    else
      echo -en "$branchname"
      echo -e " \033[0;31mUncommittedChanges\033[0;39m"
    fi
  else
    echo -en "$branchname"
    echo -e " \033[0;33mnotGitRepository\033[0;39m"
  fi
}

main | column -t

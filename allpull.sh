#!/bin/bash
listfile="`pwd`/list.txt"
fd -HI '\.git$' ~ > $listfile
while read -r line
do
        dirpath=`echo ${line%.*}`
        reponame=`echo $line | awk -F '\' '{print $(NF - 1)}'`
        echo -en "\033[0;34m$reponame\033[0;39m"
        echo -n "($dirpath)"
        cd $dirpath
        if [[ `git pull > /dev/null 2>&1 ; echo $?` = 0 ]]; then
                echo -e " : \033[0;32mSuccessful\033[0;39m"
        else
                echo -e " : \033[0;31mFailed\033[0;39m"
        fi
done < $listfile
rm $listfile


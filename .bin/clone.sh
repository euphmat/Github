#!/bin/bash
set -Ceu
array=()
function main(){
        create_textfile
        convert_text_to_array
        blank_line
        select_clone_repository
        delete_textfile
}

function create_textfile(){
        curl -s https://github.com/euphmat?tab=repositories | grep -E '.*<a href="\/euphmat\/.*"' >| repo.txt
        sed -i -e "s/^.*euphmat\/// " repo.txt
        sed -i -e "s/\" itemprop=\"name codeRepository\" >//" repo.txt
        sed -i -e "s/Github//" repo.txt
        sed -i -e "1d" repo.txt
        data_source=./repo.txt
        while read line
        do
            repository=`echo $line`
        done < $data_source
}

function convert_text_to_array(){
        repository_list=./repo.txt
        while read line
        do
                array+=($line)
        done < $repository_list
}

function select_clone_repository(){
        PS3="type Number:"
        select no in "${array[@]}"
        do
                case $no in
                        "$no")
                                git clone https://github.com/euphmat/$no 
                                break;;
                        *)
                esac
        done
}

function delete_textfile(){
        rm ./repo.txt
}

function blank_line(){
        echo ""
}

main

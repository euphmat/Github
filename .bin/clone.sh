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

# リポジトリ一覧が記載されたテキストファイルを生成
function create_textfile(){
        curl -s https://github.com/euphmat?tab=repositories | grep -E '.*<a href="\/euphmat\/.*"' >| repo.txt
        sed -i -e "s/^.*euphmat\/// " repo.txt
        sed -i -e "s/\" itemprop=\"name codeRepository\" >//" repo.txt
        data_source=./repo.txt
        while read line
        do
            repository=`echo $line`
        done < $data_source
}

# テキストファイルに記載されたリポジトリ一覧を配列に格納
function convert_text_to_array(){
        repository_list=./repo.txt
        while read line
        do
                array+=($line)
        done < $repository_list
}

# 配列リポジトリ名を読み込み、メニューとして画面上に表示
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

# テキストファイルを削除
function delete_textfile(){
        rm ./repo.txt
}

# 画面上に改行を表示
function blank_line(){
        echo ""
}

main

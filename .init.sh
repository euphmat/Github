#!/bin/bash
set -Ceu

function main(){
    install_homebrew
    install_git
    install_github_repository
    dotscript
}

function install_homebrew(){
    if [[ `type brew > /dev/null 2>&1; echo $?` = 0 ]]; then
        echo "✅ Homebrew Already Installed."
    else
        echo "installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
}

function install_git(){
    if [[ `type git > /dev/null 2>&1; echo $?` = 0 ]]; then
        echo "✅ Git Already Installed."
    else
        echo "installing Git..."
        brew install git
    fi
}

function install_github_repository(){
    cd ~
    if [[ -d ./Github/ ]]; then
        echo "✅ The Github directory already exists."
    else
        git clone https://github.com/euphmat/Github
        cd ~/Github/
        curl https://github.com/euphmat?tab=repositories | grep -E '.*<a href="\/euphmat\/.*"' >| repo.txt
        sed -i -e "s/^.*euphmat\/// " repo.txt
        sed -i -e "s/\" itemprop=\"name codeRepository\" >//" repo.txt
        sed -i -e "s/Github//" repo.txt
        sed -i -e "1d" repo.txt
        data_source=./repo.txt
        while read line
        do
            repository_name=`echo $line`
            `git clone https://github.com/euphmat/$repository_name`
        done < $data_source
        rm repo.txt
    fi
}

function dotscript(){
    cd ~/github/dotfiles/bin
    ./defaults.sh
    ./install_package.sh
    ./setting_tool.sh
    ./deploy.sh
}

main

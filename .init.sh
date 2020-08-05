#!/bin/bash
set -Cu

# install Homebrew
if [[ `type brew > /dev/null 2>&1; echo $?` = 0 ]]; then
        echo "Homebrew Already Installed."
else
        echo "installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# install Git
if [[ `type git > /dev/null 2>&1; echo $?` = 0 ]]; then
        echo "Git Already Installed."
else
        echo "installing Git..."
        brew install git
fi

# Check Github Directory && Clone 
cd ~
if [[ -d ./Github/ ]]; then
        echo "The Github directory already exists."
else
        git clone https://github.com/euphmat/Github
        cd Github/
        curl https://github.com/euphmat?tab=repositories | grep -E '.*<a href="\/euphmat\/.*"' | sed -e "s/^.*euphmat\/// "| sed -e "s/\" itemprop=\"name codeRepository\" >//" | sed -e "s/Github//" > repo.txt
        data_source=./repo.txt
        while read line
        do
                repository_name=`echo $line`
                git clone https://github.com/euphmat/$repository_name

        done < $data_source
fi
rm repo.txt

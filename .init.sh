#!/bin/bash
set -Ceu

# Githubディレクトリが存在するかチェック
cd ~
if [[ -d ./Github/ ]]; then
        echo "ある"
else
        echo "ない"
fi

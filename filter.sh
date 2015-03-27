#!/bin/bash

list=$(cat filter.txt)

cd $1

git filter-branch --prune-empty \
    --index-filter "git rm --cached -rf --ignore-unmatch $(echo $list)" \
    --tag-name-filter cat -- --all

cd -

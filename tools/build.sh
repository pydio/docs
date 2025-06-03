#!/bin/bash
set -x
source ~/.venv/bin/activate

SOURCE_MKDOCS="/home/pydio/go/src/github.com/pydio/mkdocs"
LOCAL_MKDOCS="/tmp/mkdocs"
GIT_REPO="/tmp/git-docs"

rm -rf "$LOCAL_MKDOCS"
mkdir -p "$LOCAL_MKDOCS"
cd "$LOCAL_MKDOCS"
git init

cp -r "$SOURCE_MKDOCS/overrides" "$LOCAL_MKDOCS/"
cp -r "$SOURCE_MKDOCS/resources" "$LOCAL_MKDOCS/"
cp -r "$SOURCE_MKDOCS/mkdocs.yml" "$LOCAL_MKDOCS/"

git add .
git commit -m "add mkdocs stuff"


cd "$GIT_REPO"
git checkout cells-v4
cd "$LOCAL_MKDOCS"
mike deploy  cells-v4 latest

# cd "$GIT_REPO"
# git checkout cells-v3
# cd "$LOCAL_MKDOCS"
# mike deploy  cells-v3

# cd "$GIT_REPO"
# git checkout cells-v2
# cd "$LOCAL_MKDOCS"
# mike deploy  cells-v2

# cd "$GIT_REPO"
# git checkout cells-v1
# cd "$LOCAL_MKDOCS"
# mike deploy  cells-v1

cd "$GIT_REPO"
git checkout pydio-v8
cd "$LOCAL_MKDOCS"
mike deploy  pydio-v8

mike set-default cells-v4


git checkout gh-pages
# Override versions.json for version ordering
cat  "$SOURCE_MKDOCS/resources/versions.json" | tee versions.json
cat  "$SOURCE_MKDOCS/resources/.htaccess" | tee .htaccess
cp -r "$SOURCE_MKDOCS/resources" "cells-v4/"
cp -r "$SOURCE_MKDOCS/resources" "pydio-v8/"


sudo rm -rf /var/www/html/*
sudo cp -r ./* /var/www/html/
cat  "$SOURCE_MKDOCS/resources/fix_index.html" | sudo tee "/var/www/html/cells-v4/index.html"
cat  "$SOURCE_MKDOCS/resources/fix_index.html" | sudo tee "/var/www/html/pydio-v8/index.html"

sudo chown www-data: -R /var/www/html/


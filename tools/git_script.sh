#!/bin/bash

set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LOCAL_REPO_ADMIN_GUIDE="/home/pydio/go/src/github.com/pydio/pydio-doc-admin-guide"
LOCAL_REPO_DEVELOPER_GUIDE="/home/pydio/go/src/github.com/pydio/pydio-doc-developer-guide"
LOCAL_REPO_KB="/home/pydio/go/src/github.com/pydio/pydio-doc-howto"
LOCAL_MKDOCS="/home/pydio/go/src/github.com/pydio/mkdocs"

GIT_REPO_LOCAL="/tmp/git-docs"
rm -rf "$GIT_REPO_LOCAL"
mkdir -p "$GIT_REPO_LOCAL"

ADMIN_GUIDE="$GIT_REPO_LOCAL/admin-guide"
DEVELOPER_GUIDE="$GIT_REPO_LOCAL/developer-guide"
KB="$GIT_REPO_LOCAL/knowledge-base"
FLOWS="$GIT_REPO_LOCAL/cellsflows"

CELLS_V4_RELATIVE_URL="mkdocs/cells-v4"
PYDIO_V8_RELATIVE_URL="mkdocs/pydio-v8"

cd "$GIT_REPO_LOCAL"
git init
git checkout -b main
cat << EOF >> index.md
Welcome to Pydio documentation
EOF

git add .
git commit -m "Initialize main branch"

mkdir -p "$ADMIN_GUIDE"
mkdir -p "$DEVELOPER_GUIDE"

git add .
git commit -m "Initialize Folders"

# Add docs for pydio-v8
git checkout -b pydio-v8

cd "$LOCAL_REPO_ADMIN_GUIDE"
git checkout v8
"$SCRIPT_DIR/convertor.sh" ./ "$ADMIN_GUIDE" "$PYDIO_V8_RELATIVE_URL"

cd "$LOCAL_REPO_DEVELOPER_GUIDE"
git checkout v8
"$SCRIPT_DIR/convertor.sh" ./ "$DEVELOPER_GUIDE" "$PYDIO_V8_RELATIVE_URL"

cd "$LOCAL_REPO_KB"
git checkout master
"$SCRIPT_DIR/convertor.sh" ./ "$KB" "$PYDIO_V8_RELATIVE_URL"
# TODO delete cells articles
find "$KB" -maxdepth 1 -type f ! -name "p8_*" -exec rm -v {} \;

cd "$GIT_REPO_LOCAL"
"$SCRIPT_DIR/generate_toc.sh" ./ "$PYDIO_V8_RELATIVE_URL"

git add .
git commit -m "Add pydio-v8 documentation"

# Add docs for cells v1
# git checkout main
# git checkout -b cells-v1

# cd "$LOCAL_REPO_ADMIN_GUIDE"
# git checkout cells-v1
# "$SCRIPT_DIR/convertor.sh" ./ "$ADMIN_GUIDE" "cells-v1"

# cd "$LOCAL_REPO_DEVELOPER_GUIDE"
# git checkout cells-v1
# "$SCRIPT_DIR/convertor.sh" ./ "$DEVELOPER_GUIDE" "cells-v1"

# cd "$GIT_REPO_LOCAL"
# "$SCRIPT_DIR/generate_toc.sh" ./ "cells-v1"

# git add .
# git commit -m "Add cells-v1 documentation"


# # Add docs for cells v2
# git checkout main

# git checkout -b cells-v2

# mkdir -p "$KB"
# git add .
# git commit -m "Add knowledge folder"

# cd "$LOCAL_REPO_ADMIN_GUIDE"
# git checkout cells-v2
# "$SCRIPT_DIR/convertor.sh" ./ "$ADMIN_GUIDE" "cells-v2"

# cd "$LOCAL_REPO_DEVELOPER_GUIDE"
# git checkout cells-v2
# "$SCRIPT_DIR/convertor.sh" ./ "$DEVELOPER_GUIDE" "cells-v2"

# cd "$LOCAL_REPO_KB"
# git checkout cells-v2
# "$SCRIPT_DIR/convertor.sh" ./ "$KB" "cells-v2"

# cd "$GIT_REPO_LOCAL"
# "$SCRIPT_DIR/generate_toc.sh" ./ "cells-v2"

# git add .
# git commit -m "Add cells-v2 documentation"

# # Add docs for cells v3
# git checkout main
# mkdir -p "$FLOWS"
# git add .
# git commit -m "Add CellsFlows folder"

# git checkout -b cells-v3
# mkdir -p "$FLOWS"
# git add .
# git commit -m "Add CellsFlows folder"

# cd "$LOCAL_REPO_ADMIN_GUIDE"
# git checkout cells-v3
# "$SCRIPT_DIR/convertor.sh" ./ "$ADMIN_GUIDE" "cells-v3"

# cd "$LOCAL_REPO_DEVELOPER_GUIDE"
# git checkout cells-v2
# "$SCRIPT_DIR/convertor.sh" ./ "$DEVELOPER_GUIDE" "cells-v3"

# cd "$LOCAL_REPO_KB"
# git checkout cells-v2
# "$SCRIPT_DIR/convertor.sh" ./ "$KB" "cells-v3"

# #cells-flows
# cd "$LOCAL_REPO_DEVELOPER_GUIDE"
# git checkout cells-flows
# "$SCRIPT_DIR/convertor.sh" ./ "$FLOWS" "cells-v3"


# cd "$GIT_REPO_LOCAL"
# "$SCRIPT_DIR/generate_toc.sh" ./ "cells-v3"

# git add .
# git commit -m "Add cells-v3 documentation"


# Add docs for cells v4
git checkout main
git checkout -b cells-v4

cd "$LOCAL_REPO_ADMIN_GUIDE"
git checkout cells-v4
"$SCRIPT_DIR/convertor.sh" ./ "$ADMIN_GUIDE" "$CELLS_V4_RELATIVE_URL"

cd "$LOCAL_REPO_DEVELOPER_GUIDE"
git checkout cells-v2
"$SCRIPT_DIR/convertor.sh" ./ "$DEVELOPER_GUIDE" "$CELLS_V4_RELATIVE_URL"

cd "$LOCAL_REPO_KB"
git checkout cells-v2
"$SCRIPT_DIR/convertor.sh" ./ "$KB" "$CELLS_V4_RELATIVE_URL"
# remove legacy doc in knowledge-base folder and other p8 files
rm -rf "$KB/legacy"
rm -rf "$KB/plugins_setting_up_emailers.md"
rm -rf "$KB/plugins_task_scheduler.md"

cd "$LOCAL_REPO_DEVELOPER_GUIDE"
git checkout cells-flows
"$SCRIPT_DIR/convertor.sh" ./ "$FLOWS" "$CELLS_V4_RELATIVE_URL"


cd "$GIT_REPO_LOCAL"
"$SCRIPT_DIR/generate_toc.sh" ./ "$CELLS_V4_RELATIVE_URL"

git add .
git commit -m "Add cells-v4 documentation"

#############

cd "$GIT_REPO_LOCAL"
git checkout pydio-v8
mkdir -p  "$LOCAL_MKDOCS/docs/pydio-v8"
cp -r ./* "$LOCAL_MKDOCS/docs/pydio-v8"

# git checkout cells-v1
# mkdir -p  "$LOCAL_MKDOCS/docs/cells-v1"
# cp -r ./* "$LOCAL_MKDOCS/docs/cells-v1"

# git checkout cells-v2
# mkdir -p  "$LOCAL_MKDOCS/docs/cells-v2"
# cp -r ./* "$LOCAL_MKDOCS/docs/cells-v2"

# git checkout cells-v3
# mkdir -p  "$LOCAL_MKDOCS/docs/cells-v3"
# cp -r ./* "$LOCAL_MKDOCS/docs/cells-v3"

git checkout cells-v4
mkdir -p  "$LOCAL_MKDOCS/docs/cells-v4"
cp -r ./* "$LOCAL_MKDOCS/docs/cells-v4"

# git checkout cells-v5
# mkdir -p  "$LOCAL_MKDOCS/docs/cells-v5"
# cp -r ./* "$LOCAL_MKDOCS/docs/cells-v5"
# Add index file for sections
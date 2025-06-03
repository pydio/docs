#!/bin/bash

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
cd  "${SCRIPT_DIR}"

./convertor.sh ../../pydio-doc-admin-guide/ ../docs/admin-guide "/"
./convertor.sh ../../pydio-doc-developer-guide/ ../docs/developer-guide/ "/"
./generate_toc.sh ../docs "/"


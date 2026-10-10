#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"
export MPLBACKEND=Agg

if [ ! -x "venv/bin/python3" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Invoke the environment's interpreter directly on both macOS and Linux.
# This does not depend on activate scripts or the caller's PATH.
venv_python="$PWD/venv/bin/python3"
"$venv_python" -m pip install -r requirements.txt
mkdir -p ../images

if [ "$#" -eq 0 ]; then
    # Positional arguments also handle an empty directory under Bash 3.2's
    # nounset mode (an empty array expansion would fail there).
    shopt -s nullglob
    set -- *.py
fi

for file in "$@"
do
    if [ ! -f "$file" ]; then
        echo "Python script not found: $file"
        exit 1
    fi

    echo "Running $file..."
    "$venv_python" "$file" quiet savepdf savesvg
done

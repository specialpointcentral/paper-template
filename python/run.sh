#!/bin/env bash

if [ ! -d "venv" ]; then
    mkdir venv
fi

echo "Creating virtual environment..."

python3 -m venv venv
source venv/bin/activate

# install requirements
if command -v pip3 &>/dev/null; then
    pip3 install -r requirements.txt
else
    echo "No pip3 found."
    exit 1
fi

# run python scripts
if ! command -v python3 &>/dev/null; then
    echo "No python3 interpreter found."
    exit 1
fi

if [ "$#" -gt 0 ]; then
    files=("$@")
elif compgen -G "*.py" > /dev/null; then
    files=(*.py)
else
    files=()
fi

for file in "${files[@]}"
do
    if [ ! -f "$file" ]; then
        echo "Python script not found: $file"
        exit 1
    fi

    echo "Running $file..."
    python3 "$file" quiet savepdf savesvg
done

# deactivate virtual environment
deactivate

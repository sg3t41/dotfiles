#!/bin/bash

# figletが存在しない場合は標準で出力
if command -v figlet > /dev/null; then
    output=$(figlet ready)
else
    output="welcome"
fi

echo "$output"
echo "$(date)"


#!/bin/bash

welcome_message="welcome"

# figletが存在しない場合は標準で出力
if command -v figlet > /dev/null; then
    output=$(figlet $welcome_message)
else
    output=$welcome_message
fi

echo "$output"
echo "$(date)"


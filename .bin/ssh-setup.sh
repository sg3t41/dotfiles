#!/bin/bash
# SSH鍵をssh-agentに追加

# SSH Agentが起動していない場合は起動
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# GitHub用のSSH鍵を追加
if [ -f ~/.ssh/github_id ]; then
    echo "GitHub SSH鍵を追加します..."
    ssh-add ~/.ssh/github_id
else
    echo "エラー: ~/.ssh/github_id が見つかりません"
    exit 1
fi

# 登録された鍵を確認
echo -e "\n登録されたSSH鍵:"
ssh-add -l
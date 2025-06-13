#!/bin/bash
# Claude Desktop Logs Cleaner - シンプル版
# ログを消すだけ

set -e

CLAUDE_LOG_DIR="$HOME/.config/Claude/logs"

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Claude Logs Cleaner${NC}"
echo "===================="

# ディレクトリ存在チェック
if [[ ! -d "$CLAUDE_LOG_DIR" ]]; then
    echo -e "${RED}ログディレクトリが存在しません: $CLAUDE_LOG_DIR${NC}"
    exit 1
fi

# 現在のサイズ表示
current_size=$(du -sh "$CLAUDE_LOG_DIR" | cut -f1)
echo "現在のログサイズ: $current_size"

# Claudeが動いているかチェック
if pgrep -f "claude" > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Claude Desktop が実行中です${NC}"
fi

echo
read -p "ログを全削除しますか? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "削除中..."
    rm -rf "$CLAUDE_LOG_DIR"/*
    echo -e "${GREEN}✅ ログ削除完了！${NC}"
    
    # 結果表示
    new_size=$(du -sh "$CLAUDE_LOG_DIR" 2>/dev/null | cut -f1 || echo "0")
    echo "削除後のサイズ: $new_size"
else
    echo "キャンセルしました"
fi

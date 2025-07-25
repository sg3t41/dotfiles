.PHONY: all local secret-reveal secret-hide

all: local

help:
	@echo "使用可能なターゲット:"
	@echo "  (デフォルト)  - dotfilesをローカルインストール"
	@echo "  local        - dotfilesをローカルインストール"
	@echo "  secret-reveal - git secret で秘密ファイルを復元"
	@echo "  secret-hide  - git secret で秘密ファイルを隠蔽"

local: 
	@echo "dotfilesをローカルにインストールします..."
	@bash ./setup/setup.sh git bash nvim ssh starship llm bin

secret-reveal:
	@echo "秘密ファイルを復元します..."
	@git secret reveal
	@echo "SSH秘密鍵のパーミッションを修正します..."
	@if [ -f ~/.ssh/github ]; then chmod 0600 ~/.ssh/github; fi

secret-hide:
	@echo "秘密ファイルを隠蔽します..."
	@git secret hide

.PHONY: all local docker-build docker-run docker clean help

all: local

help:
	@echo "使用可能なターゲット:"
	@echo "  (デフォルト)  - dotfilesをローカルインストール"
	@echo "  local        - dotfilesをローカルインストール"
	@echo "  docker-build - Dockerイメージをビルド"
	@echo "  docker-run   - Dockerコンテナを実行"
	@echo "  docker       - Dockerイメージのビルドと実行"
	@echo "  clean        - Dockerイメージを削除"

local:
	@bash .bin/install.sh

docker-build:
	docker build -t dotfiles .

docker-run: docker-build
	docker run -it --rm dotfiles

docker: docker-run

clean:
	docker rmi dotfiles 2>/dev/null || true
	docker system prune -f
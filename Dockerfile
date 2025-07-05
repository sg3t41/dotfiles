FROM ubuntu:24.04

# 1. システムの依存関係とツールのインストール (時間のかかる処理を先に)
RUN apt update && \
	apt install -y \
	curl \
	git \
	ripgrep \
	tar \
	unzip \
	vim \
	wget \
	build-essential \
	tmux \
	locales \
	cargo \
	cmake \
	libssl-dev \
	xsel \
	golang

# 日本語ロケールの設定
RUN locale-gen ja_JP.UTF-8

# Neovimのインストール
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz && \
	tar -zxvf nvim-linux64.tar.gz && \
	mv nvim-linux64/bin/nvim /usr/bin/nvim && \
	mv nvim-linux64/lib/nvim /usr/lib/nvim && \
	mv nvim-linux64/share/nvim/ /usr/share/nvim && \
	rm -rf nvim-linux64 && \
	rm nvim-linux64.tar.gz

# Node.js (LTS) のインストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
	apt install -y nodejs

# Denoのインストール
RUN curl -fsSL https://deno.land/x/install/install.sh | sh

# Starshipのインストール
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# 2. dotfilesをコンテナにコピー (この行より上がキャッシュされる)
COPY . /dotfiles

# 3. dotfilesのインストールと設定
RUN bash /dotfiles/.bin/dotfiles-installer.sh

# Neovimのプラグインをインストール
RUN nvim --headless :Lazy! +qa

# 最終的なコマンド
CMD ["/bin/bash"]

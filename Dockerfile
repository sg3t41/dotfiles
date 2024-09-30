FROM ubuntu:24.04

RUN apt update && \
	apt-get update && \
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
	nodejs \
	cargo \
	cmake \
	libssl-dev \
	ripgrep

RUN locale-gen ja_JP.UTF-8

RUN wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz && \
	tar -zxvf nvim-linux64.tar.gz && \
	mv nvim-linux64/bin/nvim usr/bin/nvim && \
	mv nvim-linux64/lib/nvim usr/lib/nvim && \
	mv nvim-linux64/share/nvim/ usr/share/nvim && \
	rm -rf nvim-linux64 && \
	rm nvim-linux64.tar.gz

COPY . /dotfiles

RUN cargo install starship

RUN bash dotfiles/.bin/install.sh

RUN nvim --headless :Lazy! +qa

CMD ["/bin/bash"]

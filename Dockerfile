FROM ubuntu:24.04

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

RUN locale-gen ja_JP.UTF-8

RUN wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz && \
	tar -zxvf nvim-linux64.tar.gz && \
	mv nvim-linux64/bin/nvim usr/bin/nvim && \
	mv nvim-linux64/lib/nvim usr/lib/nvim && \
	mv nvim-linux64/share/nvim/ usr/share/nvim && \
	rm -rf nvim-linux64 && \
	rm nvim-linux64.tar.gz

# nodejs (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
	apt install -y nodejs

# deno
RUN curl -fsSL https://deno.land/x/install/install.sh | sh

# NERDFont Hack
# RUN git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
# RUN cd nerd-fonts && ./install.sh Hack
# RUN fc-cache -fv

#starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

COPY . /dotfiles

RUN bash dotfiles/.bin/install.sh

RUN nvim --headless :Lazy! +qa

CMD ["/bin/bash"]

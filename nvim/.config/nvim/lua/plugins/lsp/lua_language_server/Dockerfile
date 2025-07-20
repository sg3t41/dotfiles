FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y build-essential git socat ninja-build

RUN git clone https://github.com/luals/lua-language-server /opt/lua-language-server
WORKDIR /opt/lua-language-server
RUN ./make.sh

# socatを使い、8888番ポートへのTCP接続を、LSPサーバーの標準入出力(stdio)に繋ぎます
CMD ["socat", "TCP-LISTEN:8888,fork", "EXEC:'./bin/lua-language-server'"]

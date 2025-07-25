# ~/.bashrc: bash(1)によりnon-loginシェル用に実行される
# 例については /usr/share/doc/bash/examples/startup-files (bash-docパッケージ内)
# を参照してください

# 対話的でない場合は何もしない
[ -z "$PS1" ] && return

# 履歴に重複行を追加しない。詳細は bash(1) を参照
# ... または ignoredups と ignorespace を強制
HISTCONTROL=ignoredups:ignorespace

# 履歴ファイルに追記する（上書きしない）
shopt -s histappend

# 履歴の長さ設定は bash(1) の HISTSIZE と HISTFILESIZE を参照
HISTSIZE=1000
HISTFILESIZE=2000

# 各コマンド後にウィンドウサイズをチェックし、必要に応じて
# LINES と COLUMNS の値を更新する
shopt -s checkwinsize

# less をテキスト以外の入力ファイルに対してより親切にする。lesspipe(1)を参照
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# 作業中のchroot環境を識別する変数を設定（下記のプロンプトで使用）
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# カラープロンプトを設定（色が「欲しい」ことが分かっている場合以外は非カラー）
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# カラーサポートあり。Ecma-48準拠と仮定
	# (ISO/IEC-6429)。このサポートがない場合は極めて稀で、
	# そのような場合は setaf ではなく setf をサポートする傾向がある
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# xtermの場合、タイトルを user@host:dir に設定
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ls のカラーサポートを有効にし、便利なエイリアスを追加
if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ターミナル起動時のスクリプト読み込み
if [ -d "$HOME/.config/bash/scripts" ]; then
    for script in "$HOME/.config/bash/scripts"/*; do
        if [ -f "$script" ]; then
            . "$script"
        fi
    done
fi

# エイリアス定義の読み込み
if [ -d "$HOME/.config/bash/aliases" ]; then
    for alias_file in "$HOME/.config/bash/aliases"/*; do
        if [ -f "$alias_file" ]; then
            . "$alias_file"
        fi
    done
fi

# PATH重複防止関数（同じパスを何度も追加しないようにする）
add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

# シェル設定の読み込み（環境変数、PATH等）
if [ -d "$HOME/.config/bash/shell" ]; then
    # shell ディレクトリ直下のファイルを読み込む
    for shell_config in "$HOME/.config/bash/shell"/*; do
        if [ -f "$shell_config" ]; then
            . "$shell_config"
        fi
    done

    # env/env ファイルを明示的に読み込む
    if [ -f "$HOME/.config/bash/shell/env/env" ]; then
        source "$HOME/.config/bash/shell/env/env"
    fi
fi

# システムサービス設定の読み込み（SSH等）
if [ -d "$HOME/.config/bash/system" ]; then
    for system in "$HOME/.config/bash/system"/*; do
        if [ -f "$system" ]; then
            . "$system"
        fi
    done
fi

# ソフトウェア設定の読み込み
if [ -d "$HOME/.config/bash/software" ]; then
    for software in "$HOME/.config/bash/software"/*; do
        if [ -f "$software" ]; then
            . "$software"
        fi
    done
fi

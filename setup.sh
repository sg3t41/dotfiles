#!/bin/bash

# --- グローバル変数とプレフィックス ---
info_prefix="[INFO]" # INFOプレフィックスを復活
error_prefix="[ERROR]"
success_prefix="[SUCCESS]"

# --- 関数定義 ---

## 引数（stowパッケージ名）の有無をチェックする関数
# 引数がある場合は 0 を、ない場合は 1 を返す
check_args_exists() {
	if [ "$#" -eq 0 ]; then
		echo "$info_prefix 引数が指定されていません。"
		echo "$info_prefix stowでシンボリックリンクに指定するパッケージ名を引数に追加してください。"
		echo "例: $0 git nvim tmux"
		return 1 # 失敗（引数なし）
	fi
	return 0 # 成功（引数あり）
}

## 指定されたパッケージフォルダが存在するかどうかをチェックする関数
# 引数: $1 - チェックするstowパッケージ名
# フォルダが存在すれば 0 を、存在しなければ 1 を返す
check_package_exists() {
	local package_name="$1"
	# stowパッケージが現在のディレクトリにあると仮定
	local stow_package_path="./$package_name"

	if [ ! -d "$stow_package_path" ]; then
		echo "$error_prefix パッケージフォルダ '$stow_package_path' が存在しません。パッケージ名が正しいか確認してください。"
		return 1 # 失敗
	fi
	return 0 # 成功
}

## 単一のパッケージをstowし、結果を表示する関数
# stowが失敗したらエラーメッセージを出力し、失敗を示す 1 を返す
# 成功したら成功メッセージを出力し、成功を示す 0 を返す
process_stow_package() {
	local package_name="$1"

	# stowを実行し、出力を画面に表示しつつ、成功/失敗をチェック
	# 2>&1 は標準出力と標準エラー出力をまとめる
	if stow -v -S -t ~/ "$package_name" 2>&1; then
		echo "$success_prefix パッケージ '$package_name' のシンボリックリンクが正常に作成されました。"
		return 0 # 成功
	else
		# stowが失敗した場合、エラーメッセージを出力
		echo "$error_prefix パッケージ '$package_name' の処理中に問題が発生しました。"
		echo "$error_prefix stow の実行に失敗しました。詳細については、上記出力ログを確認してください。"
		return 1 # 失敗
	fi
}

# --- メイン処理 ---

echo "$info_prefix stowによるドットファイル管理スクリプトを開始します。"
echo "--------------------------------------------------------"

# 1. 引数の存在チェックを実行し、失敗したら終了
check_args_exists "$@" || exit 1

# 2. 全てのパッケージフォルダが存在するかを事前にチェックし、存在しなければ終了
for package in "$@"; do
	check_package_exists "$package" || exit 1
done

echo ""
echo "--- 全パッケージのstow処理を開始します ---"

# 3. 全ての引数（パッケージ名）をループで処理し、stow関数に渡す
# process_stow_package関数が失敗(return 1)したら、exit 1 を実行
for package in "${@}"; do
	process_stow_package "$package" || exit 1
done

echo "--- 全パッケージのstow処理が完了しました ---"
echo "--------------------------------------------------------"

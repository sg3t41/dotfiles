#!/bin/bash
set -ue

#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#
helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

install_dotfiles_with_stow() {
  command echo "Installing dotfiles with stow..."
  
  # スクリプトの場所を取得
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  
  # dotfilesのルートディレクトリを探す（.gitがある場所）
  local dotfiles_root_dir="${script_dir}"
  while [[ "${dotfiles_root_dir}" != "/" ]]; do
    if [[ -d "${dotfiles_root_dir}/.git" ]] || [[ -f "${dotfiles_root_dir}/.gitignore" ]]; then
      break
    fi
    dotfiles_root_dir="$(dirname "${dotfiles_root_dir}")"
  done
  
  # もしくは、明示的にdotfilesディレクトリを指定
  if [[ ! -d "${dotfiles_root_dir}/bash" ]]; then
    # スクリプトの場所から../../でdotfilesのルートに移動
    dotfiles_root_dir="$(cd "${script_dir}/../.." && pwd -P)"
  fi
  
  local home_dir="${HOME}"
  
  # dotfilesディレクトリに移動
  pushd "${dotfiles_root_dir}" > /dev/null
  
  command echo "Working in: $(pwd)"
  
  # stowで管理するパッケージのリスト
  local packages=(
    "bash"
    "bin"
    "claude"
    "gemini"
    "git"
    "kitty"
    "nvim"
    "ssh"
    "starship"
    "tmux"
  )
  
  for pkg in "${packages[@]}"; do
    command echo "Processing package: ${pkg}"
    
    # パッケージが存在するかチェック（ディレクトリまたはファイル）
    if [[ ! -e "${pkg}" ]]; then
      command echo "Warning: Package '${pkg}' does not exist, skipping..."
      continue
    fi
    
    # ディレクトリでない場合は警告
    if [[ ! -d "${pkg}" ]]; then
      command echo "Warning: '${pkg}' is not a directory, skipping..."
      continue
    fi
    
    command echo "Processing package: ${pkg}"
    
    # 既存のリンクを削除 (クリーンな状態にするため)
    stow -D "${pkg}" 2>/dev/null || true
    
    # 新しいリンクを作成 (ホームディレクトリをターゲットに指定)
    if ! stow -t "${home_dir}" "${pkg}" 2>/dev/null; then
      command echo "Error: Failed to stow package '${pkg}'"
      
      # 特別な処理：binパッケージの場合は.binファイルをバックアップ
      if [[ "${pkg}" == "bin" ]] && [[ -e "${home_dir}/.bin" ]]; then
        local backup_file="${home_dir}/.bin.backup.$(date +%Y%m%d_%H%M%S)"
        command echo "Creating backup: ${home_dir}/.bin -> ${backup_file}"
        mv "${home_dir}/.bin" "${backup_file}"
        
        # 再試行
        if stow -t "${home_dir}" "${pkg}"; then
          command echo "Successfully stowed '${pkg}' after creating backup"
          continue
        fi
      fi
      
      # 一般的な競合ファイルのバックアップ処理
      local backup_created=false
      
      # パッケージ内のファイルを確認してバックアップを作成
      if [[ -d "${pkg}" ]]; then
        # findの結果をwhile readで処理（プロセス置換を使用）
        while IFS= read -r -d '' file; do
          # パッケージ内のファイルのホームディレクトリでの相対パス
          local rel_path="${file#${pkg}/}"
          local target_file="${home_dir}/${rel_path}"
          
          # 既存のファイルまたはリンクが存在する場合
          if [[ -e "${target_file}" ]]; then
            local backup_file="${target_file}.backup.$(date +%Y%m%d_%H%M%S)"
            command echo "Creating backup: ${target_file} -> ${backup_file}"
            mv "${target_file}" "${backup_file}"
            backup_created=true
          fi
        done < <(find "${pkg}" -type f -o -type l -print0)
      fi
      
      # バックアップを作成した場合は再試行
      if [[ "${backup_created}" == "true" ]]; then
        if stow -t "${home_dir}" "${pkg}"; then
          command echo "Successfully stowed '${pkg}' after creating backup"
          continue
        fi
      fi
      
      # それでも失敗した場合の対処
      command echo "Checking for remaining conflicts..."
      
      # 競合ファイルがある場合の対処オプション
      read -p "Do you want to adopt existing files for ${pkg}? (y/n): " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        if stow -t "${home_dir}" --adopt "${pkg}"; then
          command echo "Successfully adopted files for '${pkg}'"
        else
          command echo "Failed to adopt files for '${pkg}'"
        fi
      else
        command echo "Skipping package '${pkg}' due to conflicts"
        continue
      fi
    fi
  done
  
  popd > /dev/null # 元のディレクトリに戻る
}

#--------------------------------------------------------------#
##          Main                                              ##
#--------------------------------------------------------------#
IS_INSTALL="true"

while [ $# -gt 0 ]; do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    install)
      IS_INSTALL="true"
      ;;
    *)
      ;;
  esac
  shift
done

if [[ "$IS_INSTALL" = true ]]; then
  install_dotfiles_with_stow
  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(basename $0) install success!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi

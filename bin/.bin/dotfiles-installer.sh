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
  local dotfiles_root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local home_dir="${HOME}"
  
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
    # 絶対パスを使用してstowを実行
    stow -d "${dotfiles_root_dir}/../.." -t "${home_dir}" -D "${pkg}" 2>/dev/null || true
    stow -d "${dotfiles_root_dir}/../.." -t "${home_dir}" "${pkg}" 2>/dev/null || true
  done
}

#--------------------------------------------------------------#
##          Main                                              ##
#--------------------------------------------------------------#

IS_INSTALL="true"

while [ $# -gt 0 ];do
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

if [[ "$IS_INSTALL" = true ]];then
  install_dotfiles_with_stow
  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(basename $0) install success!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi

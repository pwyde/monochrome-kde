#!/usr/bin/env bash

# Install script for Monochrome KDE
# Copyright (C) 2019 Patrik Wyde <path@wyde.se>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Configure script variables.
git_repo="monochrome-kde"
git_desc="Monochrome KDE"
prefix="/usr/share"
tag="master"
install="false"
uninstall="false"

temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

_print_header() {
echo "                                             
   _____                 _                        _____ ____  _____ 
  |     |___ ___ ___ ___| |_ ___ ___ _____ ___   |  |  |    \|   __|
  | | | | . |   | . |  _|   |  _| . |     | -_|  |    -|  |  |   __|
  |_|_|_|___|_|_|___|___|_|_|_| |___|_|_|_|___|  |__|__|____/|_____|   

  $git_desc
  https://gitlab.com/pwyde/$git_repo
" >&2
}

_print_help() {
echo "
Description:
  Install script for the ${git_desc} theme.
  Script will automatically download the latest version from the Git repository
  and copy the required files to '${prefix}'.

Examples:
  Install: ${0} --install
  Uninstall: ${0} --uninstall
 
Options:
  -i, --install      Install theme in default location (${prefix}).
 
  -u, --uninstall    Uninstall theme.
" >&2
}

# Print help if no argument is specified.
if [[ "${#}" -le 0 ]]; then
    _print_header
    _print_help
    exit 1
fi
 
# Loop as long as there is at least one more argument.
while [[ "${#}" -gt 0 ]]; do
    arg="${1}"
    case "${arg}" in
        # This is an arg value type option. Will catch both '-i' or
        # '--install' value.
        -i|--install) install="true" ;;
        # This is an arg value type option. Will catch both '-u' or
        # '--uninstall' value.
        -u|--uninstall) uninstall="true" ;;
        # This is an arg value type option. Will catch both '-h' or
        # '--help' value.
        -h|--help) _print_header; _print_help; exit ;;
        *) echo "Invalid option '${arg}'." >&2; _print_header; _print_help; exit 1 ;;
    esac
    # Shift after checking all the cases to get the next option.
    shift
done

_print_msg() {
    echo "=>" "${@}" >&2
}

# Delete parent directories if empty.
_delete_dir() {
    sudo rm -rf "${1}"
    sudo rmdir -p "$(dirname "${1}")" 2>/dev/null || true
}

_cleanup() {
    rm -rf "${temp_file}" "${temp_dir}"
    _print_msg "Completed!"
}

_download_pkg() {
    _print_msg "Downloading latest version from master branch..."
    wget -O "${temp_file}" "https://gitlab.com/pwyde/${git_repo}/-/archive/${tag}/${git_repo}-${tag}.tar.gz"
    _print_msg "Extracting archive..."
    tar -xzf "${temp_file}" -C "${temp_dir}"
}

_install_pkg() {
    _print_msg "Installing ${git_desc} to '${prefix}'..."
    sudo cp -R \
        "${temp_dir}/${git_repo}-${tag}/aurorae" \
        "${temp_dir}/${git_repo}-${tag}/color-schemes" \
        "${temp_dir}/${git_repo}-${tag}/konsole" \
        "${temp_dir}/${git_repo}-${tag}/Kvantum" \
        "${temp_dir}/${git_repo}-${tag}/plasma" \
        "${temp_dir}/${git_repo}-${tag}/sddm" \
        "${temp_dir}/${git_repo}-${tag}/yakuake" \
        "${prefix}"
}

_uninstall_pkg() {
    _print_msg "Uninstalling ${git_desc}..."
    _delete_dir "${prefix}/aurorae/themes/Monochrome"
    _delete_dir "${prefix}/color-schemes/Monochrome.colors"
    _delete_dir "${prefix}/konsole/Monochrome.colorscheme"
    _delete_dir "${prefix}/Kvantum/Monochrome"
    _delete_dir "${prefix}/plasma/desktoptheme/Monochrome"
    _delete_dir "${prefix}/plasma/look-and-feel/com.gitlab.pwyde.monochrome-kde"
    _delete_dir "${prefix}/sddm/themes/monochrome"
    _delete_dir "${prefix}/yakuake/skins/monochrome"
}

if [[ "${uninstall}" = "false" && "${install}" = "true" ]]; then
    _print_header
    _download_pkg
    _uninstall_pkg
    _install_pkg
    _cleanup
elif [[ "${uninstall}" = "true" && "${install}" = "false" ]]; then
    _print_header
    _download_pkg
    _uninstall_pkg
    _cleanup
else
    _print_msg "Missing or invalid options, see help below."
    _print_header
    _print_help
    exit 1
fi

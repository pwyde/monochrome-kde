#!/bin/bash

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

print_header() {
echo "                                             
   _____                 _                        _____ ____  _____ 
  |     |___ ___ ___ ___| |_ ___ ___ _____ ___   |  |  |    \|   __|
  | | | | . |   | . |  _|   |  _| . |     | -_|  |    -|  |  |   __|
  |_|_|_|___|_|_|___|___|_|_|_| |___|_|_|_|___|  |__|__|____/|_____|   

  $git_desc
  https://gitlab.com/pwyde/$git_repo
" >&2
}

print_help() {
echo "
Description:
  Install script for the ${git_desc} theme.
  Script will automatically download the latest version from the Git repository
  and copy the required files to '${prefix}'.

Examples:
  Install: ${0} -i
  Uninstall: ${0} -u
 
Options:
  -i    Install theme in default location.
 
  -u    Uninstall theme.
" >&2
}
 
while getopts ":i :u :f: :h" opt; do
    case $opt in
        i)
            install="true"
        ;;
        u)
            uninstall="true"
        ;;
        h)
            print_header
            print_help
        exit 1
        ;;
        \?)
            echo "Invalid option '-${OPTARG}'." >&2
            exit 1
        ;;
        *)
            # Unknown option.
        ;;
    esac
done

print_msg() {
    echo "=>" "${@}" >&2
}

# Delete parent directories if empty.
delete_dir() {
    sudo rm -rf "${1}"
    sudo rmdir -p "$(dirname "${1}")" 2>/dev/null || true
}

cleanup() {
    rm -rf "${temp_file}" "${temp_dir}"
    print_msg "Completed!"
}

download_pkg() {
    print_msg "Downloading latest version from master branch ..."
    wget -O "${temp_file}" "https://gitlab.com/pwyde/${git_repo}/-/archive/${tag}/${git_repo}-${tag}.tar.gz"
    print_msg "Extracting archive ..."
    tar -xzf "${temp_file}" -C "${temp_dir}"
}

install_pkg() {
    print_msg "Installing ${git_desc} to '${prefix}' ..."
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

uninstall_pkg() {
    print_msg "Uninstalling ${git_desc} ..."
    delete_dir "${prefix}/aurorae/themes/Monochrome"
    delete_dir "${prefix}/color-schemes/Monochrome.colors"
    delete_dir "${prefix}/konsole/Monochrome.colorscheme"
    delete_dir "${prefix}/Kvantum/Monochrome"
    delete_dir "${prefix}/plasma/desktoptheme/Monochrome"
    delete_dir "${prefix}/plasma/look-and-feel/com.gitlab.pwyde.monochrome-kde"
    delete_dir "${prefix}/sddm/themes/monochrome"
    delete_dir "${prefix}/yakuake/skins/monochrome"
}

if [[ "${uninstall}" = "false" && "${install}" = "true" ]]; then
    print_header
    download_pkg
    uninstall_pkg
    install_pkg
    cleanup
elif [[ "${uninstall}" = "true" && "${install}" = "false" ]]; then
    print_header
    download_pkg
    uninstall_pkg
    cleanup
else
    print_msg "Missing or invalid options, see help below."
    print_header
    print_help
fi

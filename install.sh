#!/usr/bin/env bash

# Install script for Monochrome KDE
# Copyright (C) 2019 Patrik Wyde <patrik@wyde.se>
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
status=""
git_hosting="gitlab.com"
git_repo="monochrome-kde"
git_desc="Monochrome KDE"
prefix="/usr/share"
branch="master"
install="false"
uninstall="false"
## Colorize output.
# shellcheck disable=SC2034
red="\033[91m"
# shellcheck disable=SC2034
green="\033[92m"
# shellcheck disable=SC2034
blue="\033[94m"
# shellcheck disable=SC2034
yellow="\033[93m"
# shellcheck disable=SC2034
cyan="\033[96m"
# shellcheck disable=SC2034
magenta="\033[95m"
# shellcheck disable=SC2034
white="\033[1m"
# shellcheck disable=SC2034
no_color="\033[0m"

temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

# Source and package arrays.
src=("${temp_dir}/${git_repo}-${branch}/aurorae"
     "${temp_dir}/${git_repo}-${branch}/color-schemes"
     "${temp_dir}/${git_repo}-${branch}/konsole"
     "${temp_dir}/${git_repo}-${branch}/Kvantum"
     "${temp_dir}/${git_repo}-${branch}/plasma"
     "${temp_dir}/${git_repo}-${branch}/sddm"
     "${temp_dir}/${git_repo}-${branch}/yakuake")
pkg=("${prefix}/aurorae/themes/Monochrome"
     "${prefix}/aurorae/themes/MonochromeBlur"
     "${prefix}/color-schemes/Monochrome.colors"
     "${prefix}/konsole/Monochrome.colorscheme"
     "${prefix}/Kvantum/Monochrome"
     "${prefix}/Kvantum/MonochromeBlur"
     "${prefix}/Kvantum/MonochromeSolid"
     "${prefix}/plasma/desktoptheme/Monochrome"
     "${prefix}/plasma/look-and-feel/com.gitlab.pwyde.monochrome-kde"
     "${prefix}/sddm/themes/monochrome"
     "${prefix}/yakuake/skins/monochrome")

print_header() {
echo -e "
   ${blue}_____                 _                        _____ ____  _____
  |     |___ ___ ___ ___| |_ ___ ___ _____ ___   |  |  |    \|   __|
  | | | | . |   | . |  _|   |  _| . |     | -_|  |    -|  |  |   __|
  |_|_|_|___|_|_|___|___|_|_|_| |___|_|_|_|___|  |__|__|____/|_____|${no_color}

  ${yellow}${git_desc}${no_color}
  https://${git_hosting}/pwyde/${git_repo}
" >&1
}

print_help() {
echo -e "
${white}Description:${no_color}
  Install script for the ${git_desc} theme.
  Script will automatically download the latest version from the Git repository
  and copy the required files to '${prefix}'.

${white}Examples:${no_color}
  Install: ${0} --install
  Uninstall: ${0} --uninstall

${white}Options:${no_color}
  ${cyan}-i${no_color}, ${cyan}--install${no_color}      Install theme in default location (${prefix}).

  ${cyan}-u${no_color}, ${cyan}--uninstall${no_color}    Uninstall theme.
" >&1
}

# Print help if no argument is specified.
if [ "${#}" -le 0 ]; then
    print_header
    print_help
    exit 1
fi

# Loop as long as there is at least one more argument.
while [ "${#}" -gt 0 ]; do
    arg="${1}"
    case "${arg}" in
        # This is an arg value type option. Will catch both '-i' or
        # '--install' value.
        -i|--install) shift; install="true" ;;
        # This is an arg value type option. Will catch both '-u' or
        # '--uninstall' value.
        -u|--uninstall) shift; uninstall="true" ;;
        # This is an arg value type option. Will catch both '-h' or
        # '--help' value.
        -h|--help) print_header; print_help; exit ;;
        *) echo "Invalid option '${arg}'." >&2; print_header; print_help; exit 1 ;;
    esac
    # Shift after checking all the cases to get the next option.
    shift > /dev/null 2>&1;
done

print_msg() {
    echo -e "$green=>$no_color$white" "$@" "$no_color" >&1
}

print_error() {
    echo -e "$red=> ERROR:$no_color$white" "$@" "$no_color" >&2
}

print_status() {
    if [ -z "${status}" ]; then
        print_msg "Completed!"
    else
        print_error "Completed with errors!"
    fi
}

# Delete parent directories if empty.
delete_dir() {
    sudo rm -rf "${1}"
    sudo rmdir -p "$(dirname "${1}")" 2>/dev/null || true
}

cleanup() {
    rm -rf "${temp_file}" "${temp_dir}" "${HOME}"/.cache/plasma-svgelements-Monochrome* "${HOME}"/.cache/plasma_theme_Monochrome*.kcache >/dev/null 2>&1
    if [ -e "${temp_file}" ]; then
        print_error "Unable to delete temporary file '${temp_file}'!"
        status=1
    fi
    if [ -e "${temp_dir}" ]; then
        print_error "Unable to delete temporary directory '${temp_dir}'!"
        status=1
    fi
}

download_pkg() {
    # Test if wget command exists on system.
    if ! command -v wget >/dev/null 2>&1; then
        print_error "Could not locate wget command!"
        print_error "Install wget using system's package manager."
        print_error "Exiting..."
        exit 1
    fi
    # Test if Git hosting provider is reachable.
    print_msg "Verifying that Git hosting provider ($git_hosting) is reachable..."
    if ping -c 5 "${git_hosting}" >/dev/null 2>&1; then
        print_msg "Downloading latest version from $branch branch..."
        wget --progress=bar:force --output-document "${temp_file}" "https://${git_hosting}/pwyde/${git_repo}/-/archive/${branch}/${git_repo}-${branch}.tar.gz"
        print_msg "Extracting archive..."
        tar -xzf "${temp_file}" -C "${temp_dir}"
    else
        print_error "Unable to communicate with Git hosting provider ($git_hosting)! Exiting..."
        exit 1
    fi
}

install_pkg() {
    print_msg "Installing ${git_desc} to '${prefix}'..."
    for item in "${src[@]}"; do
        sudo cp -R "${item}" "${prefix}"
        if [ ! -e "${item}" ]; then
            print_error "Unable to copy '${item}'!"
            status=1
        fi
    done
}

uninstall_pkg() {
    print_msg "Uninstalling ${git_desc}..."
    for item in "${pkg[@]}"; do
        delete_dir "${item}"
        if [ -e "${item}" ]; then
            print_error "Unable to delete '${item}'!"
            status=1
        fi
    done
}

if [ "${uninstall}" = "false" ] && [ "${install}" = "true" ]; then
    print_header
    download_pkg
    uninstall_pkg
    install_pkg
    cleanup
    print_status
elif [ "${uninstall}" = "true" ] && [ "${install}" = "false" ]; then
    print_header
    download_pkg
    uninstall_pkg
    cleanup
    print_status
else
    print_error "Missing or invalid options, see help below."
    print_header
    print_help
    exit 1
fi

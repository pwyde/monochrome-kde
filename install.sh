#!/bin/sh

set -e

git_repo="monochrome-kde"
git_desc="Monochrome KDE"

cat <<- EOF
   _____                 _                        _____ ____  _____ 
  |     |___ ___ ___ ___| |_ ___ ___ _____ ___   |  |  |    \|   __|
  | | | | . |   | . |  _|   |  _| . |     | -_|  |    -|  |  |   __|
  |_|_|_|___|_|_|___|___|_|_|_| |___|_|_|_|___|  |__|__|____/|_____|
                                                                  
  $git_desc
  https://gitlab.com/pwyde/$git_repo

EOF

: "${PREFIX:=/usr}"
: "${TAG:=master}"
: "${uninstall:=false}"

_msg() {
    echo "=>" "$@" >&2
}

_rm() {
    # Removes parent directories if empty.
    sudo rm -rf "$1"
    sudo rmdir -p "$(dirname "$1")" 2>/dev/null || true
}

_download() {
    _msg "Downloading latest version from master branch ..."
    wget -O "$temp_file" \
        "https://gitlab.com/pwyde/$git_repo/-/archive/$TAG/$git_repo-$TAG.tar.gz"
    _msg "Extracting archive ..."
    tar -xzf "$temp_file" -C "$temp_dir"
}

_uninstall() {
    _msg "Deleting $git_desc ..."
    _rm "$PREFIX/share/aurorae/themes/Monochrome"
    _rm "$PREFIX/share/color-schemes/Monochrome.colors"
    _rm "$PREFIX/share/konsole/Monochrome.colorscheme"
    _rm "$PREFIX/share/Kvantum/Monochrome"
    _rm "$PREFIX/share/plasma/desktoptheme/Monochrome"
    _rm "$PREFIX/share/plasma/look-and-feel/com.gitlab.pwyde.monochrome-kde"
    _rm "$PREFIX/share/yakuake/skins/monochrome"
    _rm "$PREFIX/share/sddm/themes/monochrome"
}

_install() {
    _msg "Installing ..."
    sudo cp -R \
        "$temp_dir/$git_repo-$TAG/aurorae" \
        "$temp_dir/$git_repo-$TAG/color-schemes" \
        "$temp_dir/$git_repo-$TAG/konsole" \
        "$temp_dir/$git_repo-$TAG/Kvantum" \
        "$temp_dir/$git_repo-$TAG/plasma" \
        "$temp_dir/$git_repo-$TAG/yakuake" \
        "$temp_dir/$git_repo-$TAG/sddm" \
        "$PREFIX/share"
}

_cleanup() {
    _msg "Clearing cache ..."
    rm -rf "$temp_file" "$temp_dir" \
        ~/.cache/plasma-svgelements-Monochrome* \
        ~/.cache/plasma_theme_Monochrome*.kcache
    _msg "Done!"
}

trap _cleanup EXIT HUP INT TERM

temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

if [ "$uninstall" = "false" ]; then
    _download
    _uninstall
    _install
else
    _uninstall
fi


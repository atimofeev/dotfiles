#!/bin/bash

# Get current location of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LINKS_ONLY=false
INSTALLER="Unknown"
declare -a TARGET_APPS

detect_package_manager() {
    if [ -n "$PREFIX" ] && command -v pkg >/dev/null; then
        INSTALLER="pkg install -yq"
    elif command -v apt-get >/dev/null; then
        INSTALLER="sudo apt-get install -yq"
    elif command -v dnf >/dev/null; then
        INSTALLER="sudo dnf install -yq"
    elif command -v yum >/dev/null; then
        INSTALLER="sudo yum install -yq"
    elif command -v pacman >/dev/null; then
        INSTALLER="sudo pacman -S --noconfirm"
    elif command -v zypper >/dev/null; then
        INSTALLER="sudo zypper install -yq"
    elif command -v pkg >/dev/null; then
        INSTALLER="sudo pkg install -yq"
    fi
}

install_app() {
    local app_dir="$1"

    if [ $LINKS_ONLY = true ]; then
        echo "Setting symlinks for $app_dir"
        get_symlinks "$app_dir"
    else
        echo "Installing $app_dir..."
        install_requirements "$app_dir"
        execute_install_script "$app_dir"
        get_symlinks "$app_dir"
    fi
}

install_requirements() {
    local app_dir="$1"
    if [[ -f "$app_dir/requirements.txt" ]]; then
        while IFS= read -r requirement || [[ -n "$requirement" ]]; do
            if [[ -z "$requirement" ]]; then
                continue
            fi
            echo "Found requirement: $requirement"
            install_app "$requirement"
        done <"$app_dir/requirements.txt"
    fi
}

execute_install_script() {
    local app_dir="$1"
    if [[ -f "$app_dir/install.sh" ]]; then
        echo "Launching $app_dir install.sh"
        (cd "$app_dir" && bash install.sh)
    fi
}

get_symlinks() {
    local app_dir="$1"
    if [[ -f "$app_dir/symlinks.txt" ]]; then
        while IFS= read -r link || [[ -n $link ]]; do
            [[ "$link" =~ ^# || -z "$link" ]] && continue
            while [[ $link =~ \$DIR || $link =~ \$HOME ]]; do
                link=${link/\$DIR/$DIR}
                link=${link/\$HOME/$HOME}
            done
            eval src="${link%=*}"
            eval dest="${link#*=}"
            src=${src%/}
            dest=${dest%/}
            create_symlink "$src" "$dest"
        done <"$app_dir/symlinks.txt"
    fi
}

create_symlink() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo "Source $src does not exist. Skipping..."
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Removing existing file or symlink at $dest"
        rm -rf "$dest"
    fi

    mkdir --parents "$(dirname "$dest")"
    echo "Creating symlink $src -> $dest"
    ln -s "$src" "$dest"
}

parse_args() {
    if [ "$#" -eq 0 ]; then
        echo "No arguments provided. Use --all to install all or specify individual apps."
        exit 1
    fi

    while (("$#")); do
        case "$1" in
            -l | --links)
                LINKS_ONLY=true
                shift
                ;;
            *)
                if [[ -d $1 ]]; then
                    TARGET_APPS+=("$1")
                else
                    echo "Warning: '$1' is not a recognized app directory."
                fi
                shift
                ;;
        esac
    done
}

main() {
    parse_args "$@"
    detect_package_manager
    export INSTALLER
    for app in "${TARGET_APPS[@]}"; do
        install_app "$app"
    done
    echo "Installation complete."
}

main "$@"

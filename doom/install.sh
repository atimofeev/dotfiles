# TODO: resolve dependencies with install from source
# TODO: make install universal across distros
# https://www.emacswiki.org/emacs/GccEmacs
# https://www.emacswiki.org/emacs/BuildingEmacs
# https://git.savannah.gnu.org/cgit/emacs.git/tree/INSTALL?h=emacs-29
# https://git.savannah.gnu.org/cgit/emacs.git/tree/INSTALL.REPO?h=emacs-29
TMP_DIR=/tmp

declare build_branch
declare build_opts
declare -A build_deps

declare -A fedora_runtime_deps=(
    [native-comp] = "libgccjit"
    [pure-gtk] = "gtk3 gtk4"
    [images] = "libjpeg libpng libtiff libgif"
    [c-json] = "jansson"
    [latex] = "texlive 'tex(unicode.sty)'"
    [uncat] = "libXaw liblockfile libotf")

build() {
    git clone git://git.savannah.gnu.org/emacs.git $TMP_DIR/emacs/$build_branch
    cd $TMP_DIR/emacs/$build_branch
    git checkout $build_branch
    ./autogen.sh
    ./configure $build_opts
    make -j$(nproc)
}

build-install() {
    cd $TMP_DIR/emacs/$build_branch
    sudo make install
    #rm -rf $TMP_DIR/emacs/$build_branch
}

build-someguy-reddit() {
# https://www.reddit.com/r/emacs/comments/13qlwg0/comment/jlfgr9r/?utm_source=reddit&utm_medium=web2x&context=3
    build_deps=(
        #[core] = "gcc make autoconf texinfo"
        [native-comp] = "libgccjit-devel" # More info: https://akrl.sdf.org/gccemacs.html
        [pure-gtk] = "gtk3-devel gtk4-devel"
        [images] = "libjpeg-devel libpng-devel libtiff-devel libgif-devel"
        [c-json] = "jansson-devel"
        [misc] = "libvterm-devel webkit2gtk5.0-devel gnutls-devel")


}

build-pgtk-nativecomp-copr() {
# https://copr.fedorainfracloud.org/coprs/deathwish/emacs-pgtk-nativecomp/
# https://github.com/A6GibKm/emacs-pgtk-nativecomp-copr/blob/master/emacs.spec
    build_deps=(
        [core] = "gcc make autoconf texinfo util-linux"
        [native-comp] = "libgccjit-devel" # More info: https://akrl.sdf.org/gccemacs.html
        [pure-gtk] = "gtk3-devel webkit2gtk3-devel"
        [system-and-security] = "dbus-devel glibc-devel libselinux-devel systemd-devel systemd-rpm-macros libacl-devel gnutls-devel gnupg2"
        [gui-and-fonts] = "atk-devel cairo cairo-devel freetype-devel fontconfig-devel libpng-devel libjpeg-turbo-devel libjpeg-turbo libtiff-devel harfbuzz-devel librsvg2-devel"
        [x11] = "libX11-devel libXau-devel libXdmcp-devel libXrender-devel libXt-devel libXpm-devel xorg-x11-proto-devel"
        [general-dev] = "libtree-sitter-devel ncurses-devel zlib-devel desktop-file-utils liblockfile-devel libxml2-devel jansson-devel lcms2-devel"
        [misc] = "gzip bzip2 libotf-devel m17n-lib-devel alsa-lib-devel gpm-devel")

    build_branch=""

    build_opts="--with-dbus --with-gif --with-jpeg --with-png --with-rsvg \
            --with-tiff --with-xft --with-xpm --with-gpm=no \
            --with-xwidgets --with-modules --with-harfbuzz --with-cairo --with-json \
            --with-pgtk --with-native-compilation --enable-link-time-optimization --with-tree-sitter"

    build
}

build-bleeding-emacs() {
# https://copr.fedorainfracloud.org/coprs/alternateved/bleeding-emacs/
    build_deps=""

    build_branch=""

    build_opts=""
}

install-pgtk-nativecomp-copr() {
    sudo dnf copr enable deathwish/emacs-pgtk-nativecomp
    sudo dnf install emacs
}

install-bleeding-emacs() {
    sudo dnf copr enable alternateved/bleeding-emacs
    sudo dnf install bleeding-emacs
}

install-doom() {
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
}

main() {
    install-pgtk-nativecomp-copr
    install-doom
}

main

# TODO: resolve dependencies with install from source
# TODO: make install universal across distros
# https://www.emacswiki.org/emacs/GccEmacs
# https://www.emacswiki.org/emacs/BuildingEmacs
# https://git.savannah.gnu.org/cgit/emacs.git/tree/INSTALL?h=emacs-29
# https://git.savannah.gnu.org/cgit/emacs.git/tree/INSTALL.REPO?h=emacs-29
TMP_DIR=/tmp

#COMPILE_DEPS="texinfo libX11-devel gtk3-devel libgccjit-devel libXpm-devel giflib-devel gnutls-devel"

#$INSTALLER $COMPILE_DEPS
#
#git clone git://git.savannah.gnu.org/emacs.git $TMP_DIR/emacs
#cd $TMP_DIR/emacs
#git checkout emacs-29
#./autogen.sh
#./configure --with-native-compilation
#make -j$(nproc)
#
#sudo make install
#
#rm -rf $TMP_DIR/emacs

dnf copr enable deathwish/emacs-pgtk-nativecomp

dnf install emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
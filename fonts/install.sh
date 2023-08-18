URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.tar.xz
FILENAME=$(basename $URL)
TMP_DIR=/tmp/
FONT_DIR="$HOME/.local/share/fonts"

wget -q -P $TMP_DIR $URL

tar -Jxf $TMP_DIR$FILENAME -C $FONT_DIR

rm $TMP_DIR$FILENAME

fc-cache -fv

fc-list : family | grep Nerd
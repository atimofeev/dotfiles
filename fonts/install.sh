URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.tar.xz
FILENAME=$(basename $URL)
TMP_DIR=/tmp
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p $FONT_DIR

wget --quiet --output-document $TMP_DIR/$FILENAME $URL

tar -Jxf $TMP_DIR/$FILENAME --directory $FONT_DIR

rm $TMP_DIR/$FILENAME

fc-cache -fv | tail -1

fc-list : family | grep Nerd

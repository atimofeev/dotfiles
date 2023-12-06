FONT_FILE="DejaVuSansMono.tar.xz"

LATEST_RELEASE_URL="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
RELEASE_DATA=$(curl --silent $LATEST_RELEASE_URL)
DOWNLOAD_URL=$(echo $RELEASE_DATA | jq --raw-output ".assets[] | select(.name == \"$FONT_FILE\") | .browser_download_url")

TMP_DIR="/tmp"
FONT_DIR="$HOME/.local/share/fonts"

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Font not found in the latest release."
    exit 1
fi

mkdir --parents $FONT_DIR

wget --quiet --output-document $TMP_DIR/$FONT_FILE $DOWNLOAD_URL

tar -Jxf $TMP_DIR/$FONT_FILE --directory $FONT_DIR

rm $TMP_DIR/$FONT_FILE

fc-cache -fv | tail -1

fc-list : family | grep Nerd

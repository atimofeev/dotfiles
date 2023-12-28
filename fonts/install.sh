REPO_NAME="ryanoasis/nerd-fonts"
RELEASE_TAG="latest"

FILE="DejaVuSansMono.tar.xz"

LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_NAME/releases/$RELEASE_TAG"
RELEASE_DATA=$(curl --silent $LATEST_RELEASE_URL)
DOWNLOAD_URL=$(echo $RELEASE_DATA | jq --raw-output ".assets[] | select(.name == \"$FILE\") | .browser_download_url")

TMP_DIR="/tmp"
DEST_DIR="$HOME/.local/share/fonts"

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: File $FILE not found in the $RELEASE_TAG release."
    exit 1
fi

mkdir --parents $DEST_DIR

wget --quiet --output-document $TMP_DIR/$FILE $DOWNLOAD_URL

tar -Jxf $TMP_DIR/$FILE --directory $DEST_DIR

rm $TMP_DIR/$FILE

fc-cache -fv | tail -1

fc-list : family | grep Nerd

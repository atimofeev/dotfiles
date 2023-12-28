#!/usr/bin/env sh
REPO_NAME="patrickvane/shfmt"
RELEASE_TAG="latest"

FILE="shfmt_linux_amd64"
DEST_FILE="shfmt"

LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_NAME/releases/$RELEASE_TAG"
RELEASE_DATA=$(curl --silent $LATEST_RELEASE_URL)
DOWNLOAD_URL=$(echo $RELEASE_DATA | jq --raw-output ".assets[] | select(.name == \"$FILE\") | .browser_download_url")

DEST_DIR="/usr/local/bin"

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: File $FILE not found in the $RELEASE_TAG release."
    exit 1
fi

mkdir --parents $DEST_DIR

sudo wget --quiet --output-document $DEST_DIR/$DEST_FILE $DOWNLOAD_URL

sudo chmod +x $DEST_DIR/$DEST_FILE

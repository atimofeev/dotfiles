URL="https://releases.hyper.is/download/rpm"
FILE_NAME="hyper.rpm"
TMP_DIR=/tmp/

wget -q -O $TMP_DIR$FILE_NAME $URL
sudo dnf install -yq $TMP_DIR$FILE_NAME
rm $TMP_DIR$FILE_NAME
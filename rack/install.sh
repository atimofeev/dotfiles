URL="https://vcvrack.com/downloads/RackFree-2.3.0-lin-x64.zip"
FILE_NAME=$(basename $URL)
TMP_DIR=/tmp/

wget -q -P $TMP_DIR $URL
unzip -q $TMP_DIR$FILE_NAME -d $HOME/
rm $TMP_DIR$FILE_NAME
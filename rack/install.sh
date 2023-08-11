URL="https://vcvrack.com/downloads/RackFree-2.3.0-lin-x64.zip"
FILE_NAME=$(basename $URL)
TMP_DIR=/tmp/

wget -q -P $TMP_DIR $URL
unzip -q $TMP_DIR$FILE_NAME -d $HOME/
rm $TMP_DIR$FILE_NAME

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
git clone git@github.com:atimofeev/vcv-rack2-settings.git $CUR_DIR/dotfiles
git clone git@github.com:atimofeev/vcv-rack2-patches.git $HOME/repos/vcv-rack2-patches/
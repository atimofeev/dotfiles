URL="https://vcvrack.com/downloads/RackFree-2.4.0-lin-x64.zip"
FILENAME=$(basename $URL)
TMP_DIR=/tmp/

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

wget --quiet -O $TMP_DIR$FILENAME $URL
unzip -q $TMP_DIR$FILENAME -d $HOME/
rm $TMP_DIR$FILENAME

git clone git@github.com:atimofeev/vcv-rack2-settings.git $HOME/repos/vcv-rack2-settings/
git clone git@github.com:atimofeev/vcv-rack2-patches.git $HOME/repos/vcv-rack2-patches/

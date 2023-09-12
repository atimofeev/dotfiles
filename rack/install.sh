HOME_PAGE="https://vcvrack.com"
INSTALLER_URL=$(curl --silent --show-error "$HOME_PAGE/Rack" | \
grep --only-matching '<a class="button rack-button" href="/downloads/RackFree-[^"]*-lin-x64.zip">Linux x64</a>' | \
grep --only-matching 'href="[^"]*' | cut -d '"' -f2)
FULL_URL="$HOME_PAGE$INSTALLER_URL"

FILENAME=$(basename $FULL_URL)
TMP_DIR=/tmp
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

wget --quiet --output-document $TMP_DIR/$FILENAME $FULL_URL
unzip -o -q $TMP_DIR/$FILENAME -d $HOME/
rm $TMP_DIR/$FILENAME

git clone git@github.com:atimofeev/vcv-rack2-settings.git $HOME/repos/vcv-rack2-settings/
git clone git@github.com:atimofeev/vcv-rack2-patches.git $HOME/repos/vcv-rack2-patches/

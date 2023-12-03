$INSTALLER fish

chsh --shell /usr/bin/fish

HOME_BIN="$HOME/.bin"
SCRIPTS_REPO="https://raw.githubusercontent.com/atimofeev/learning/main/"

echo "Sourcing scripts..."
mkdir --parents $HOME_BIN
wget --quiet --output-document $HOME_BIN/ps_colors.py  $SCRIPTS_REPO/python/projects/ps_colors.py
wget --quiet --output-document $HOME_BIN/pclip  $SCRIPTS_REPO/python/projects/chatgpt/pclip

chmod +x $HOME_BIN/*.py $HOME_BIN/pclip

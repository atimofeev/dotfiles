$INSTALLER fish

HOME_BIN="$HOME/.bin"
SCRIPTS_REPO="https://raw.githubusercontent.com/atimofeev/learning-python/main/"

echo "Sourcing scripts..."
mkdir -p $HOME_BIN
wget --quiet -O $HOME_BIN/ps_colors.py  $SCRIPTS_REPO/projects/ps_colors.py
wget --quiet -O $HOME_BIN/pclip  $SCRIPTS_REPO/chatgpt/pclip

chmod +x $HOME_BIN/*.py $HOME_BIN/pclip
$INSTALLER fish

HOME_BIN="$HOME/.bin"
SCRIPTS_REPO="https://raw.githubusercontent.com/atimofeev/learning-python/main/"

echo "Sourcing scripts..."
mkdir --parents $HOME_BIN
wget --quiet --output-document $HOME_BIN/ps_colors.py  $SCRIPTS_REPO/projects/ps_colors.py
wget --quiet --output-document $HOME_BIN/pclip  $SCRIPTS_REPO/projects/chatgpt/pclip

chmod +x $HOME_BIN/*.py $HOME_BIN/pclip

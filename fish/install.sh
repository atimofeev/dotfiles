$INSTALLER fish

FISH_DIR="$HOME/.config/fish/"
SCRIPTS_REPO="https://raw.githubusercontent.com/atimofeev/learning-python/main/"

echo "Sourcing scripts..."
wget --quiet -O $FISH_DIR/ps_colors.py  $SCRIPTS_REPO/projects/ps_colors.py
wget --quiet -O $FISH_DIR/prompt_gen.py  $SCRIPTS_REPO/chatgpt/prompt_gen.py

chmod +x $FISH_DIR/*.py
# this will download and setup Nerd Font
URL=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts
wget -q -P fonts/ $URL/DejaVuSansMono/Regular/DejaVuSansMNerdFont-Regular.ttf
wget -q -P fonts/ $URL/DejaVuSansMono/Italic/DejaVuSansMNerdFont-Oblique.ttf
wget -q -P fonts/ $URL/DejaVuSansMono/Bold/DejaVuSansMNerdFont-Bold.ttf
wget -q -P fonts/ $URL/DejaVuSansMono/Bold-Italic/DejaVuSansMNerdFont-BoldOblique.ttf

FONT_DIR="$HOME/.local/share/fonts"

for font in fonts/*.ttf; do
    cp "$font" "$FONT_DIR"
done

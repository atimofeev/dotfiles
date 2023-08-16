URL=https://raw.githubusercontent.com/rupa/z/master
Z_BIN=/usr/local/bin/z
Z_MAN=/usr/local/share/man/man1/z.1

sudo wget -q -O $Z_BIN $URL/z.sh && sudo chmod +x $Z_BIN
sudo wget -q -O $Z_MAN $URL/z.1
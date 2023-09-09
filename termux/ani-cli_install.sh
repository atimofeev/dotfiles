pkg update -y ; pkg install git make termux-tools ncurses-utils openssl-tool -y ; git clone https://github.com/pystardust/ani-cli ; cd ani-cli ; cp ani-cli $PREFIX/bin/ani-cli ; chmod +x $PREFIX/bin/ani-cli ; echo 'termux-open "$2"' > $PREFIX/bin/mpv ; chmod +x $PREFIX/bin/mpv ; cd ; mkdir .cache

#install mpv-android from playstore
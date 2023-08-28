# Fedora/RHEL only

TTYD="/usr/local/bin/ttyd"
TTYD_URL="https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64"

echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo

sudo yum install -yq vhs ffmpeg
sudo wget --quiet -O $TTYD $TTYD_URL && chmod +x $TTYD

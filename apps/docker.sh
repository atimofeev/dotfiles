curl --location --silent --show-error --fail https://get.docker.com | sudo sh
sudo groupadd docker
sudo usermod -aG docker $USER
dockerd-rootless-setuptool.sh install
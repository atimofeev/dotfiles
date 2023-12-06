curl --location --silent --show-error --fail https://get.docker.com | sudo sh
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo systemctl enable docker
sudo systemctl start docker

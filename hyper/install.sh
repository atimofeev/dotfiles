# UNTESTED
TMP_DIR="./tmp"

# Create TMP_DIR if it doesn't exist
mkdir -p $TMP_DIR

curl -L https://releases.hyper.is/download/rpm -o $TMP_DIR/hyper_install.rpm
sudo dnf install -y $TMP_DIR/hyper_install.rpm
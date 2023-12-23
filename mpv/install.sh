$INSTALLER mpv playerctl

# Hack to fix MPRIS plugin compiled from older lib versions
for file in "$(pwd)"/files/scripts/mpris-libs/*; do
    filename=$(basename "$file")
    sudo ln -s "$file" /usr/lib64/"$filename"
done

# Use Alpine as the base image
FROM alpine:latest

# Set workdir
WORKDIR /root

# Mount points for access to github
COPY ssh /root/.ssh
COPY git/.gitconfig /root/.gitconfig
RUN chmod 700 /root/.ssh/

# Install build dependencies and runtime dependencies
RUN apk add --no-cache \
    build-base \
    cmake \
    ncurses-dev \
    ncurses \          
    gettext-dev \
    gettext \           
    util-linux-dev \
    curl \
    xz \
    git \
    libstdc++ \
    openssh-client \
    bash

# Download, compile and install fish shell
RUN curl -L https://github.com/fish-shell/fish-shell/releases/download/3.6.1/fish-3.6.1.tar.xz | tar xJ && \
    cd fish-3.6.1 && \
    cmake . && \
    make -j$(nproc) && \
    make install

# Get dotfiles from github and run setup script
# Includes hack to Cache Bust every build
ADD http://date.jsontest.com /etc/builddate
RUN git clone git@github.com:atimofeev/dotfiles.git && \
    ./dotfiles/setup.sh

# Clean up
RUN apk del \
    build-base \
    cmake \
    ncurses-dev \
    gettext-dev \
    util-linux-dev \
    curl \
    xz && \
    rm -rf /root/fish-3.6.1

ENTRYPOINT ["fish"]
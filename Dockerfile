# Use Alpine as the base image
FROM alpine:latest

# Set workdir
WORKDIR /tmp

# Mount points for access to github
VOLUME ~/.ssh:/root/.ssh
VOLUME ~/.gitconfig:/root/.gitconfig

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
    libstdc++

# Download, compile and install fish shell
RUN curl -L https://github.com/fish-shell/fish-shell/releases/download/3.6.1/fish-3.6.1.tar.xz | tar xJ && \
    cd fish-3.6.1 && \
    cmake . && \
    make -j$(nproc) && \
    make install

# Get dotfiles from github and run setup script
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
    rm -rf /tmp/fish-3.6.1

#COPY ./fish/ fish/
#RUN rm -rf /root/.config/fish/*
#RUN mkdir -p /root/.config/fish
#RUN cp -r /tmp/fish /root/.config/

# Set fish as the default shell
ENTRYPOINT ["/usr/local/bin/fish"]
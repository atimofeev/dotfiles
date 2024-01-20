# My dotfiles (WIP)

## Notice

**Abandonement notice**: this repo most likely will be abandoned in favor of my new [nixos-config](https://github.com/atimofeev/nixos-config) repo.

## Introduction

This repository contains a script that automates the installation of various applications and manages their respective dotfiles and configurations. Each application is housed in its own directory, which may have its specific installation script, a requirements file, and a symlinks file.

## Structure

Example directory structure:

```text
.
├── git
│  ├── files
│  ├── install.sh
├── fish
│  ├── files
│  ├── install.sh
│  ├── requirements.txt
│  └── symlinks.txt
├── hyper
│  ├── files
│  ├── install.sh
│  └── symlinks.txt
├── install.sh
└── Readme.md
```

Each application directory can contain:

- `files`: A directory with configurations specific to that application. May also contain any files required for installation.
- `install.sh`: A script that manages the installation of the application.
- `requirements.txt`: A list of other applications required to be installed prior to the current one. Each list entry should match the name of the app directory.
- `symlinks.txt`: Specifies symlinks to be created.

Remember, none of these are obligatory.

### `requirements.txt` example

```text
git
fish
```

### `symlinks.txt` example

```text
# SRC=DEST
$DIR/fish/files=$HOME/.config/fish
$DIR/fish/files/fish_history=$HOME/.local/share/fish/fish_history
```

Here, `$DIR` refers to the main `install.sh` script's current directory.

## Usage

To utilize the main installation script, proceed as follows:

1. To install a particular application:

```bash
./install.sh [application_name]
```

To install multiple apps concurrently:

```bash
./install.sh git fish
```

2. If you only want to setup symlinks for an app, use (-l | --links) flag:

```bash
./install.sh -l [application_name]
```

## Notes

- Should an application include a `requirements.txt` file, the installer will first confirm that all necessary apps have been installed before moving forward.
- `symlinks.txt` is employed to generate symbolic links. Each entry in this file depicts a symlink in the format `source=$DIR/... destination=$HOME/...`, with `$DIR` representing the script's directory and `$HOME` the user's home directory.

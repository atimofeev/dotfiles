# Readme.md

## Introduction

This repository provides a script that automates the installation of various applications and manages their respective dotfiles and configurations. Each application has its own directory which may contain its specific installation script, a requirements file, and a symlinks file.

## Structure

Example directory structure:

```text
.
├── git
│  ├── dotfiles
│  ├── install.sh
├── fish
│  ├── dotfiles
│  ├── install.sh
│  ├── requirements.txt
│  └── symlinks.txt
├── hyper
│  ├── .disabled
│  ├── dotfiles
│  ├── install.sh
│  └── symlinks.txt
├── install.sh
└── Readme.md
```

Each application directory can contain:

- `dotfiles`: A directory containing configuration related to specific application.
- `install.sh`: A script that performs the installation for that specific application.
- `requirements.txt`: A list of other applications that need to be installed before the current one. Each list entry should be equal to app name directory.
- `symlinks.txt`: A list of symlinks to be created.
- `.disabled`: You can disable any app from installation by adding this blank file. Pay attention that this won't prevent app from installing of it's listed as requirement by other app, or if it's forced to install with `-f` flag.

None of these are mandatory.

### `requirements.txt` example

```text
git
fish
```

### `symlinks.txt` example

```text
# SRC=DEST
$DIR/fish/dotfiles=$HOME/.config/fish
$DIR/fish/dotfiles/fish_history=$HOME/.local/share/fish/fish_history
```

`$DIR` is current directory of main `install.sh` script.

## Usage

To use the main installation script, follow these steps:

1. To install a specific application, run:

```bash
./install.sh [application_name]
```

You can install several apps at the same time:

```bash
./install.sh git fish
```

2. To install all applications, use:

```bash
./install.sh --all
```

3. If you want to force the re-installation of an application, even if it's already installed, use:

```bash
./install.sh -f [application_name]
```

Note: this will also ignore `.disabled` apps.

## Notes

- If an application has a `requirements.txt` file, the installer will first ensure that all required apps are installed before proceeding.
- `symlinks.txt` is used to create symbolic links. Each line in the file represents a symlink with the format `source=$DIR/... destination=$HOME/...` where `$DIR` is the directory of the script and `$HOME` is the user's home directory.
- After the successful installation of an application, a `.installed` file will be created in the respective application's directory. This file helps to identify which applications have already been installed. To reinstall an application, you need to either use the `-f` (force) flag or manually remove the `.installed` file before running the script.

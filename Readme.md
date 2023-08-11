## Introduction

This repository contains a script that automates the installation of various applications and manages their respective dotfiles and configurations. Each application is housed in its own directory, which may have its specific installation script, a requirements file, and a symlinks file.

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

- `dotfiles`: A directory with configurations specific to that application.
- `install.sh`: A script that manages the installation of the application.
- `requirements.txt`: A list of other applications required to be installed prior to the current one. Each list entry should match the name of the app directory.
- `symlinks.txt`: Specifies symlinks to be created.
- `.disabled`: Adding this blank file will prevent the app from being installed. However, if the app is listed as a requirement by another app, or if it's explicitly installed with the `-f` flag, it will still get installed.

Remember, none of these are obligatory.

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

2. For installing all applications:

```bash
./install.sh --all
```

3. If you aim to force an application's re-installation, even if it's already installed:

```bash
./install.sh -f [application_name]
```

Note: This command will also override the `.disabled` tagfile and proceed with the installation.

## Notes

- Should an application include a `requirements.txt` file, the installer will first confirm that all necessary apps have been installed before moving forward.
- `symlinks.txt` is employed to generate symbolic links. Each entry in this file depicts a symlink in the format `source=$DIR/... destination=$HOME/...`, with `$DIR` representing the script's directory and `$HOME` the user's home directory.
- After the successful setup of an app, a `.installed` file will be produced within the app's directory, indicating the completion of its installation. To reinstall an application, use the `-f` (force) flag or manually eliminate the `.installed` file before initiating the script.

if status is-interactive

end

### ENV VARS ###
set EDITOR nvim
set GOPATH /usr/local/go
set GOPATH_USR ~/go/
set RUSTPATH $HOME/.cargo/bin
set -e fish_user_paths
set -U fish_user_paths $GOPATH/bin $GOPATH_USR/bin $HOME/.bin $HOME/.local/bin $HOME/.config/emacs/bin $RUSTPATH $fish_user_paths

### APPS ###

# DOOM EMACS #
alias de='emacs --no-window-system'

# FZF #
source $HOME/.config/fish/fzf.fish

# KITTY #
if type -q kitty
    alias ssh="kitty +kitten ssh"
    alias diff="kitty +kitten diff"
end

# Z #
set -U Z_DATA "$HOME/.local/share/z/data"
set -U Z_DATA_DIR "$HOME/.local/share/z"
set -U Z_EXCLUDE "^$HOME\$"

# EZA #
if type -q eza
    alias ls='eza --color=always --group-directories-first'
    alias ll='eza -l --color=always --group-directories-first'
    alias la='eza --all -l --color=always --group-directories-first'
    alias ld='eza --list-dirs -l --color=always --group-directories-first' # list exact dir info
    alias lt='eza --tree -all --color=always --group-directories-first --level 2'
    alias l.='eza --all | egrep "^\."' # show only dotfiles
end

# BAT #
if type -q bat
    alias less='bat --color=always --style=auto'
    alias cat='bat --color=always --style=plain --paging=never'
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" # man pages -> bat
    set -x MANROFFOPT -c # bat man pages formatting fix
    function help # help [command] -> bat
        $argv --help 2>&1 | bat --plain --language=help
    end
end

# RIPGREP #
alias rg='rg --color=always --ignore-case '

# GIT # TODO: Refactor
#function mv
#    git mv $argv; or command mv --interactive $argv
#end
function gitdiff
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end
function gitdiffview
    git difftool --no-symlinks --dir-diff
end
alias og_gitdiff='/usr/bin/gitdiff'
alias og_gitdiffview='/usr/bin/gitdiffview'
alias addup='git add --update'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit --message'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag --annotate'
function git_remove_file_history
    set file_path $argv[1]

    if test -z "$file_path"
        echo "Please provide a file path to remove from Git history."
        return 1
    end

    # Ensure that the user is in a Git repository
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "You must be inside a Git repository to run this command."
        return 1
    end

    # Remove the file from Git history
    git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $file_path" --prune-empty --tag-name-filter cat -- --all

    # Remove the temporary files created by git filter-branch
    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --prune=now
    git gc --aggressive --prune=now

    echo "Successfully removed $file_path from Git history."
    # do 'git push origin --force --all' after that
end


# ARCHIVE EXTRACTION #
function ex
    if test -f "$argv[1]"
        set ext (string match -r '\..+$' "$argv[1]")
        if test "$ext" = ".tar.bz2"
            tar xjf $argv[1]
        else if test "$ext" = ".tar.gz"
            tar xzf $argv[1]
        else if test "$ext" = ".bz2"
            bunzip2 $argv[1]
        else if test "$ext" = ".rar"
            unrar x $argv[1]
        else if test "$ext" = ".gz"
            gunzip $argv[1]
        else if test "$ext" = ".tar"
            tar xf $argv[1]
        else if test "$ext" = ".tbz2"
            tar xjf $argv[1]
        else if test "$ext" = ".tgz"
            tar xzf $argv[1]
        else if test "$ext" = ".zip"
            unzip $argv[1]
        else if test "$ext" = ".Z"
            uncompress $argv[1]
        else if test "$ext" = ".7z"
            7z x $argv[1]
        else if test "$ext" = ".tar.xz"
            tar -Jxf $argv[1]
        else if test "$ext" = ".tar.zst"
            unzstd $argv[1]
        else
            echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

### ALIASES ###
alias t=terraform
alias a=ansible
alias k=kubectl
alias mk=minikube
alias d=docker
alias dstopall='docker stop $(docker ps -q)'
alias rack='cd ~/Rack2Free && ./Rack && cd -'

alias cdtl='cd $(git rev-parse --show-toplevel 2>/dev/null)'

# nvim
if type -q nvim
    alias vi='nvim'
    alias vim='nvim'
end

# [command] | tb
alias tb="nc termbin.com 9999"

alias nf='neofetch --backend off --color_blocks off'

alias chx='chmod +x'

# adding flags
alias df='df --human-readable --print-type --exclude-type=tmpfs --exclude-type=squashfs --exclude-type=devtmpfs --exclude-type=efivarfs'
alias du='du --human-readable'
alias free='free --human'
alias mkdir='mkdir --parents --verbose'
# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# confirm before overwriting something
alias cp='cp --interactive'
alias rm='rm --interactive'
#alias mv='mv --interactive'

# the terminal rickroll
alias rr='curl --silent --location \
    https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'


function touchx
    for file in $argv
        touch $file
        chmod +x $file
    end
end

function dn
    $argv 2>/dev/null
end

function list_funcs
    for func in (functions)
        #echo "Function Name: "$func
        echo
        functions $func
    end | bat --language fish
end

# starship prompt
starship init fish | source

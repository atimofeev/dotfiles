if status is-interactive

end

### ENV VARS ###
set GOPATH "$HOME/go"
set -e fish_user_paths
set -U fish_user_paths $GOPATH/bin $HOME/.bin $fish_user_paths

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" # man pages -> bat
set -x MANROFFOPT "-c"                            # bat man pages formatting fix

### APPS ###

# FZF #
source $HOME/.config/fish/fzf.fish

# KITTY #
alias s="kitty +kitten ssh"

# Z #
set -U Z_DATA "$HOME/.local/share/z/data"
set -U Z_DATA_DIR "$HOME/.local/share/z"
set -U Z_EXCLUDE "^$HOME\$"

# EXA #
alias ls='exa --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias la='exa -al --color=always --group-directories-first'
alias ld='exa -ld --color=always --group-directories-first' # list directory info
alias lt='exa -aT --color=always --group-directories-first --level 2' # tree listing
alias l.='exa -a | egrep "^\."' # show only dotfiles

# BAT #
alias less='bat --color=always --style=auto'
alias cat='bat --color=always --style=plain --paging=never'
function help # help [command] -> bat
    $argv --help 2>&1 | bat --plain --language=help
end

# RIPGREP #
alias rg='rg --color=always --ignore-case '

# SPONGE #
set sponge_successful_exit_codes 0 130

# GIT #
function mv
    git mv $argv; or command mv --interactive $argv
end
function bdiff
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end
function kdiff
    git difftool --no-symlinks --dir-diff
end
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
    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
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
        if test "$ext" = ".tar.bz2"; tar xjf $argv[1]
        else if test "$ext" = ".tar.gz"; tar xzf $argv[1]
        else if test "$ext" = ".bz2"; bunzip2 $argv[1]
        else if test "$ext" = ".rar"; unrar x $argv[1]
        else if test "$ext" = ".gz"; gunzip $argv[1]
        else if test "$ext" = ".tar"; tar xf $argv[1]
        else if test "$ext" = ".tbz2"; tar xjf $argv[1]
        else if test "$ext" = ".tgz"; tar xzf $argv[1]
        else if test "$ext" = ".zip"; unzip $argv[1]
        else if test "$ext" = ".Z"; uncompress $argv[1]
        else if test "$ext" = ".7z"; 7z x $argv[1]
        else if test "$ext" = ".tar.xz"; tar -Jxf $argv[1]
        else if test "$ext" = ".tar.zst"; unzstd $argv[1]
        else; echo "'$argv[1]' cannot be extracted via ex()"; end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

### ALIASES ###
alias t=terraform
alias a=ansible
alias k=kubectl
alias rack='cd ~/Rack2Free && ./Rack && cd -'

alias cdtl='cd $(git rev-parse --show-toplevel 2>/dev/null)'

# nvim
alias vi='nvim'
alias vim='nvim'

# [command] | tb
alias tb="nc termbin.com 9999"

alias nf='neofetch --backend off --color_blocks off'

alias chx='chmod +x'

# adding flags
alias df='df --human-readable'
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

# auto sudo
abbr dnf 'sudo dnf'

# the terminal rickroll
alias rr='curl -s -L \
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
    end | bat -l fish
end

# starship prompt
starship init fish | source

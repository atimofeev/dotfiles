if status is-interactive

end

### ENV VARS ###
set GOPATH "$HOME/go"
set PATH "$GOPATH/bin:$PATH"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"   # man pages -> bat
set -x MANROFFOPT "-c"                              # bat man pages formatting fix


### APPS ###

# Z #
#replay "source /usr/local/bin/z"
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
alias less='bat'
alias cat='bat --paging=never'
function help # help [command] -> bat
    $argv --help 2>&1 | bat --plain --language=help
end
function bdiff
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end
function fdb
    fd $argv -X bat
end

# RIPGREP #
alias rg='rg -i --color=always'

# FZF #
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix \
	--hidden --follow --exclude .git'

function fz -d "fd+fzf"
	set command $FZF_DEFAULT_COMMAND
	set editor "vi"
	set header "Press CTRL-R to reload"
	set preview "bat --color=always --style=numbers \
		--line-range=:500 {1}"
	
	echo '' | fzf \
		--header="$header" \
		--delimiter : \
		--preview $preview \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--bind "enter:execute($editor {1})"
end

function fzps -d "ps+fzf"
	set command 'ps -ejH --forest'
	#set command "ps -eHo \"%p %U %C %t %x %y %z %a\" --forest \
		# | awk 'NR==1 { print; next } /^\s*[0-9]+/ \
		# { \$7=int(\$7/1024)\"M\" } { print }' OFS='\t'"
	set header "Press CTRL-R to reload, CTRL-X to kill"
	
	eval $command | fzf \
		--header="$header" \
		--header-lines=1 \
		--height=70% \
		--layout=reverse \
		--bind "start:unbind(enter)" \
		--bind "ctrl-r:reload:$command" \
		--bind "ctrl-x:execute(kill -9 {1})+reload($command)"
end

function fzg -d "ripgrep+fzf"
	set command "rg --line-number --no-heading --color=always \
		--smart-case $argv"
	set header 'Press CTRL-R to reload'
	set preview 'bat --color=always --style=numbers	\
		--line-range=:500 {1} --highlight-line {2}'

	if test (count $argv) -eq 0
        echo "Provide search pattern!"
        return 1
    end

	echo '' | fzf --ansi \
		--header="$header" \
		--delimiter : \
		--preview $preview \
		--preview-window ":+{2}+3/3" \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--bind "enter:execute(vim {1})" 
end

function fzdu -d "du+fzf"
	set command 'du -ah . 2>/dev/null | sort -h -r | head -1000'
	set header 'Press CTRL-R to reload, Enter to advance, CTRL-X to delete'

	# TODO: fix 'enter:reload' cmd
	echo '' | fzf \
		--header="$header" \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--bind "ctrl-x:execute(rm {2})+reload($command)" \
		--bind "enter:reload(du -ah (echo {} | awk '{\$1=\"\"; print \$0}' \
			| sed 's/^ *//') 2>/dev/null | sort -h -r | head -1000)"
end

# GIT #
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
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
	switch (string match -r '\.\w+$' "$argv[1]")
		case '*.tar.bz2'
			tar xjf $argv[1]
		case '*.tar.gz'
			tar xzf $argv[1]
		case '*.bz2'
			bunzip2 $argv[1]
		case '*.rar'
			unrar x $argv[1]
		case '*.gz'
			gunzip $argv[1]
		case '*.tar'
			tar xf $argv[1]
		case '*.tbz2'
			tar xjf $argv[1]
		case '*.tgz'
			tar xzf $argv[1]
		case '*.zip'
			unzip $argv[1]
		case '*.Z'
			uncompress $argv[1]
		case '*.7z'
			7z x $argv[1]
		case '*.deb'
			ar x $argv[1]
		case '*.tar.xz'
			tar xf $argv[1]
		case '*.tar.zst'
			unzstd $argv[1]
		case '*'
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
alias rack='cd ~/Rack2Free && ./Rack && cd -'

alias mv='git mv $argv; or mv $argv'
alias cdtl='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias cd.='cd ..'
alias cd..='cd ../..'
alias cd...='cd ../../..'
alias cd....='cd ../../../..'
alias cd.....='cd ../../../../..'
alias cd......='cd ../../../../../..'

# nvim
alias vi='nvim'
alias vim='nvim'

# [command] | tb
alias tb="nc termbin.com 9999"

alias chx='chmod +x'

# adding flags
alias df='df -h'
alias free='free -h'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# auto sudo
alias dnf='sudo dnf'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

### ABBREVIATIONS ###

### FUNCTIONS ###
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

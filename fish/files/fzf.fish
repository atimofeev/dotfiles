# FZF #
set -U FZF_COMPLETE 2
set -gx FZF_EDITOR 'vi'
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix \
	--hidden --follow --exclude .git '
set -gx FZF_DEFAULT_OPTS '--ansi --height 75%'

function fz -d "fd+fzf"
	set command $FZF_DEFAULT_COMMAND
	set header "Press CTRL-R to reload, Enter to edit"
	set preview "bat --color=always --style=numbers \
		--line-range=:500 {1}"
	
	echo '' | fzf \
		--header="$header" \
		--delimiter : \
		--preview $preview \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--bind "enter:execute($FZF_EDITOR {1})"
end

function fzps -d "ps+fzf"
	set command 'ps -ef --forest | ps_colors.py'
	set header "Press CTRL-R to reload, CTRL-X to kill, Enter to return ID"
	
	eval $command | fzf \
		--header="$header" \
		--header-lines=1 \
		--height=70% \
		--layout=reverse \
		--bind "start:reload:$command" \
		--bind "enter:become(echo {2})" \
		--bind "ctrl-r:reload:$command" \
		--bind "ctrl-x:execute(kill -9 {2})+reload($command)"
end

function fzg -d "ripgrep+fzf"
    set command "rg --line-number --no-heading --color=always \
        --smart-case --fixed-strings '"$argv"'"
	set header 'Press CTRL-R to reload, Enter to edit'
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
		--bind "enter:execute($FZF_EDITOR {1} +{2})"
end

function _du_fzf
    du -ah (count $argv > 0; and echo $argv; or echo '.') \
		2>/dev/null | sort -h -r | head -1000
end
function fzdu -d "du+fzf"
	set command '_du_fzf'
	set header "Press CTRL-R to reload, Enter to advance, \
CTRL-X to delete, Alt-Enter to go up"

	echo '' | fzf \
		--header="$header" \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--bind "ctrl-x:execute(rm {2})+reload($command)" \
		--bind "enter:reload:$command {2}" \
		--bind "alt-enter:reload:$command (dirname {2})"
end

function _count_files
    for dir in (fd --hidden --absolute-path --max-depth 1 --type directory)
		echo $dir: (fd --full-path $dir --hidden --absolute-path --type file | wc -l)
    end
end
function fzwc -d "count_files+fzf"
	set command '_count_files'
	set header 'Press CTRL-R to reload, Enter to advance'

	echo '' | fzf \
		--header="$header" \
		--bind "start:reload:$command" \
		--bind "ctrl-r:reload:$command" \
		--delimiter : \
		--bind "enter:reload:cd {1} && $command" 
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

### ENV VARS ###
set GOPATH "$HOME/go"
set PATH "$GOPATH/bin:$PATH"

### ALIASES ###
alias t=terraform
alias a=ansible
alias k=kubectl
alias rack='cd ~/Rack2Free && ./Rack && cd -'

# ls -> exa
alias ls='exa --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias la='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'                             # show only dotfiles

# bat
alias less='bat'
alias cat='bat --paging=never'

# nvim
alias vi='nvim'
alias vim='nvim'

# git
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

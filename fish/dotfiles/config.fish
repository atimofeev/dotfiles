if status is-interactive
    # Commands to run in interactive sessions can go here
end

# aliases:
alias t=terraform
alias a=ansible
alias k=kubectl
alias rack='cd ~/Rack2Free && ./Rack && cd -'

# abbreviations:
abbr -a dn '2>/dev/null'

# env variables:
set GOPATH "$HOME/go"
set PATH "$GOPATH/bin:$PATH"

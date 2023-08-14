if status is-interactive
    # Commands to run in interactive sessions can go here
end

# env variables:
set GOPATH "$HOME/go"
set PATH "$GOPATH/bin:$PATH"

# aliases:
alias t=terraform
alias a=ansible
alias k=kubectl
alias rack='cd ~/Rack2Free && ./Rack && cd -'

# abbreviations:

# functions:
function touchx
    for file in $argv
        touch $file
        chmod +x $file
    end
end

function dn
    $argv 2>/dev/null
end

# Various information

## Install from scratch

```shell
sudo dnf install -y fish #fzf fd bat

fish << FISH_SCRIPT
# Disable greeting
set -g fish_greeting

# Install fisher and plugins
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install \
    jorgebucaran/fisher \
    hauleth/agnoster \
    jorgebucaran/autopair.fish \
    jorgebucaran/replay.fish \
    jethrokuan/z \
    franciscolourenco/done \
    gazorby/fish-abbreviation-tips \
    nickeb96/puffer-fish \
    meaningful-ooo/sponge \
    # yet to learn shortcuts
    #PatrickF1/fzf.fish
    #jethrokuan/fzf
    #joseluisq/gitnow@2.11.0

# Additional configuration for agnoster theme
agnoster powerline
sed -i "s/^  agnoster::context/ #agnoster::context/g" \$HOME/.config/fish/functions/fish_prompt.fish
source \$HOME/.config/fish/functions/fish_prompt.fish

# Config for Done, notification on 25s+ command execution
set -g __done_min_cmd_duration 25000
FISH_SCRIPT
```

## Useful fzf function Example

```sh
pods() {
  : | command='kubectl get pods --all-namespaces' fzf \
    --info=inline --layout=reverse --header-lines=1 \
    --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
    --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
    --bind 'start:reload:$command' \
    --bind 'ctrl-r:reload:$command' \
    --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
    --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
    --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
    --preview-window up:follow \
    --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}
```

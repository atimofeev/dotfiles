#!/bin/bash
sudo dnf install -yq fish #fzf


### FUZZY CD ###
# https://brettterpstra.com/2021/12/24/a-fuzzy-cd-command-for-fish/
## FASD ##
# https://github.com/clvv/fasd
#curl -L https://github.com/clvv/fasd/archive/refs/tags/1.0.1.tar.gz
#PREFIX=$HOME make install 

# Put in shell rc
#eval "$(fasd --init auto)"

## JUMP ##
# https://github.com/oh-my-fish/plugin-jump
# probably can be installed by manual cp, or via adding adding or listing marks
# https://jeroenjanssens.com/navigate/
#...
#fisher install ttscoff/fuzzy_cd
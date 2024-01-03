# NvChad Config

## Features

- Automatic tree-sitter modules installation (full auto discovery)
- Automatic LSP install (from list in configs/packages.lua)
- Automatic Lint/Fmt install (from list in configs/null-ls.lua)
- Automatic formatting on save
- Inline git blame
- Rainbow delimiters
- Git UI (neogit)

## Goals

### Functionality

- Debugging (nvim-dap + nvim-dap-ui + mason-nvim-dap.nvim)
- Project management (with subprojects)
- Notes (obsidian.nvim?)
  https://github.com/goshatch/orgroam_to_obsidian
  https://www.reddit.com/r/ObsidianMD/comments/qeb333/simplifying_the_transition_from_roam_to_obsidian/
- Journal
- Code completion (codeium.nvim)
- ChatGPT integration (ChatGPT.nvim)
- Enable yaml schema detection (yaml.ansible, yaml.kubernetes, yaml.docker-compose)
  https://github.com/b0o/SchemaStore.nvim (ansible, docker-compose)
  https://github.com/someone-stole-my-name/yaml-companion.nvim
  https://github.com/someone-stole-my-name/yaml-companion.nvim/issues/23
- Add [KubeLinter](https://github.com/stackrox/kube-linter)

### Settings

- Prevent scrolling past end of buffer (no more than 50% of screen)
- Apply editorconfig to formatters. [example](https://github.com/SchemaStore/schemastore/blob/master/.editorconfig)

### Issues to Fix

- All good for now!

## Useful Links

https://github.com/rockerBOO/awesome-neovim
https://github.com/NvChad/nvcommunity

## Configuration Examples

https://github.com/Alexis12119/nvim-config
https://github.com/cgxxv/custom/
https://github.com/dreamsofcode-io/neovim-python
https://github.com/dreamsofcode-io/neovim-go-config
https://github.com/dreamsofcode-io/neovim-rust

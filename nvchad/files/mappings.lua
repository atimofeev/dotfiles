---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<M-Up>"] = { "<cmd> m -2 <CR>", "Move line up" },
    ["<M-k>"] = { "<cmd> m -2 <CR>", "Move line up" },
    ["<M-Down>"] = { "<cmd> m +1 <CR>", "Move line down" },
    ["<M-j>"] = { "<cmd> m +1 <CR>", "Move line down" },
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "Open Neogit" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "Open recent files" },
    ["<leader>pp"] = { "<cmd> Telescope projects <CR>", "Open project" },
    ["<leader><leader>"] = { "<cmd> Telescope projects <CR>", "Open project" },
  },
  i = {
    ["<m-up>"] = { "<cmd> m -2 <cr>", "move line up" },
    ["<m-k>"] = { "<cmd> m -2 <cr>", "move line up" },
    ["<m-down>"] = { "<cmd> m +1 <cr>", "move line down" },
    ["<m-j>"] = { "<cmd> m +1 <cr>", "move line down" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

return M

---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<M-Up>"] = { "<cmd> m -2 <CR>", "Move line up" },
    ["<M-Down>"] = { "<cmd> m +1 <CR>", "Move line down" },
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "Open Neogit" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "Open recent files" },
    ["<leader>pp"] = { "<cmd> Telescope projects <CR>", "Open project" },
    ["<leader><leader>"] = { "<cmd> Telescope projects <CR>", "Open project" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

return M

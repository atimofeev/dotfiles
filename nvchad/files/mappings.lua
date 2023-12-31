---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "Open Neogit" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

return M

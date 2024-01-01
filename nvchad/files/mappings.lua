---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>gg"] = { "<cmd> Neogit <CR>", "Open Neogit" },

		["<M-Up>"] = { "<cmd> m -2 <CR>", "Move line up" },
		["<M-Down>"] = { "<cmd> m +1 <CR>", "Move line down" },
	},
	v = {
		[">"] = { ">gv", "indent" },
	},
}

return M

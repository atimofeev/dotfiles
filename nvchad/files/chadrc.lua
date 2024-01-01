---@type ChadrcConfig
local M = {}

M.ui = {
	nvdash = {
		load_on_startup = true,
	},
	hl_override = {
		CursorLine = {
			bg = "one_bg",
		},
	},
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M

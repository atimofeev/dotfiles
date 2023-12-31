---@type ChadrcConfig
local M = {}

M.ui = {
  nvdash = {
    load_on_startup = true,
  }
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

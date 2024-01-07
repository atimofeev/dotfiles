---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "doomchad",
  theme_toggle = { "doomchad", "onedark" },
  hl_override = {
    CursorLine = {
      bg = "darker_black",
    },
  },
  hl_add = {
    -- Neogit
    NeogitDiffAdd = { bg = "#3e493d", fg = "green" },
    NeogitDiffAddHighlight = { bg = "#3e493d", fg = "green" },
    NeogitDiffDelete = { bg = "#392d34", fg = "red" },
    NeogitDiffDeleteHighlight = { bg = "#392d34", fg = "red" },
    NeogitDiffContextHighlight = { bg = "black2" },
    NeogitHunkHeader = { bg = "lightbg" },
    NeogitHunkHeaderHighlight = { bg = "grey" },
    -- RainbowDelimiters
    RainbowDelimiterRed = { fg = "blue" },
    RainbowDelimiterYellow = { fg = "dark_purple" },
    RainbowDelimiterBlue = { fg = "green" },
    RainbowDelimiterOrange = { fg = "pink" },
    RainbowDelimiterGreen = { fg = "blue" },
    RainbowDelimiterViolet = { fg = "dark_purple" },
    RainbowDelimiterCyan = { fg = "green" },
  },
  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

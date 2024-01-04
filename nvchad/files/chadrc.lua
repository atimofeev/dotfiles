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
    RainbowDelimiterRed = { fg = "#51afef" },
    RainbowDelimiterYellow = { fg = "#c678dd" },
    RainbowDelimiterBlue = { fg = "#98be65" },
    RainbowDelimiterOrange = { fg = "#a9a1e1" },
    RainbowDelimiterGreen = { fg = "#51afef" },
    RainbowDelimiterViolet = { fg = "#c678dd" },
    RainbowDelimiterCyan = { fg = "#98be65" },
  },
  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

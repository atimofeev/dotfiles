---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "onedark" },
  -- hl_override = {
  --   --catppuccin theme colors:
  --   --white #bbc2cf
  --   --blue #51afef
  --   --dark_purple #c678dd
  --   --green #98be65
  --   --pink #ff75a0
  --   ["@constant"] = { fg = "#ba96c8" },
  --   ["@constant.builtin"] = { fg = "dark_purple" },
  --   ["@punctuation.delimiter"] = { fg = "white" },
  --   ["@punctuation.bracket"] = { fg = "white" },
  --   ["@punctuation.special"] = { fg = "blue" },
  --   ["@parameter"] = { fg = "#dcaeea" },
  --   ["Include"] = { fg = "blue" },
  --   ["@operator"] = { fg = "blue" },
  --   ["Number"] = { fg = "#a9a1e1" },
  --   ["@method.call"] = { fg = "blue", bold = true, italic = true },
  --   ["@function.builtin"] = { fg = "dark_purple" }, --should be applied excusively
  --   ["@function.call"] = { fg = "blue", bold = true }, --but for builtin calls both are applied
  --   ["@field"] = { fg = "#a9a1e1", italic = false },
  --   ["Boolean"] = { fg = "dark_purple" },
  --   ["@constructor"] = { fg = "#ecbe7b" },
  --   ["@type.builtin"] = { fg = "#ecbe7b" },
  --   ["@exception"] = { fg = "pink" },
  --   ["Repeat"] = { fg = "blue" },
  --   ["@function"] = { fg = "dark_purple" },
  --   ["@property"] = { fg = "#dcaeea" },
  --   ["@lsp.type.string"] = { fg = "green" },
  --   --["@constant.call"] = {fg = "#a9a1e1"}, --non-existent in TS
  --   --["@variable.declaration"] = {fg = "#dcaeea"}, --non-existent in TS
  --
  --   CursorLine = {
  --     bg = "darker_black",
  --   },
  -- },
  -- hl_add = {
  --   -- Neogit
  --   NeogitDiffAdd = { bg = "#3e493d", fg = "green" },
  --   NeogitDiffAddHighlight = { bg = "#3e493d", fg = "green" },
  --   NeogitDiffDelete = { bg = "#392d34", fg = "red" },
  --   NeogitDiffDeleteHighlight = { bg = "#392d34", fg = "red" },
  --   NeogitDiffContextHighlight = { bg = "black2" },
  --   NeogitHunkHeader = { bg = "lightbg" },
  --   NeogitHunkHeaderHighlight = { bg = "grey" },
  --   -- RainbowDelimiters
  --   RainbowDelimiterRed = { fg = "blue" },
  --   RainbowDelimiterYellow = { fg = "dark_purple" },
  --   RainbowDelimiterBlue = { fg = "green" },
  --   RainbowDelimiterOrange = { fg = "pink" },
  --   RainbowDelimiterGreen = { fg = "blue" },
  --   RainbowDelimiterViolet = { fg = "dark_purple" },
  --   RainbowDelimiterCyan = { fg = "green" },
  -- },
  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

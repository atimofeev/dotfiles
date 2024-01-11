---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "doomchad",
  theme_toggle = { "doomchad", "onedark" },
  hl_override = {
    --doomchad theme colors:
    --white #bbc2cf
    --blue #51afef
    --dark_purple #c678dd
    ["@constant"] = { fg = "#ba96c8" },
    ["@constant.builtin"] = { fg = "#c678dd" },
    ["@punctuation.delimiter"] = { fg = "#bbc2cf" },
    ["@punctuation.bracket"] = { fg = "#bbc2cf" },
    ["@punctuation.special"] = { fg = "#51afef" },
    ["@parameter"] = { fg = "#dcaeea" },
    ["Include"] = { fg = "#51afef" },
    ["@operator"] = { fg = "#51afef" },
    ["Number"] = { fg = "#a9a1e1" },
    ["@method.call"] = { fg = "#51afef", bold = true, italic = true },
    ["@function.builtin"] = { fg = "#c678dd" }, --should be applied excusively
    ["@function.call"] = { fg = "#51afef", bold = true }, --but for builtin calls both are applied
    ["@field"] = { fg = "#a9a1e1", italic = false },
    ["Boolean"] = { fg = "#c678dd" },
    ["@constructor"] = { fg = "#ecbe7b" },
    ["@type.builtin"] = { fg = "#ecbe7b" },
    ["@exception"] = { fg = "pink" },
    ["Repeat"] = { fg = "#51afef" },
    ["@function"] = { fg = "#c678dd" },
    ["@property"] = { fg = "#dcaeea" },
    ["@lsp.type.string"] = { fg = "green" },
    --["@constant.call"] = {fg = "#a9a1e1"}, --non-existent in TS
    --["@variable.declaration"] = {fg = "#dcaeea"}, --non-existent in TS

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

local M = {}

local function adjust_brightness(color, factor)
  local r = tonumber(color:sub(2, 3), 16)
  local g = tonumber(color:sub(4, 5), 16)
  local b = tonumber(color:sub(6, 7), 16)

  r = math.min(255, r * factor)
  g = math.min(255, g * factor)
  b = math.min(255, b * factor)

  return string.format("#%02x%02x%02x", r, g, b)
end

function M.setup()
  local colors_file = io.open(vim.fn.expand('~/.cache/wal/colors'), 'r')
  if not colors_file then return end

  local colors = {}
  for line in colors_file:lines() do
    table.insert(colors, adjust_brightness(line, 1.4)) -- Adjust brightness by 40%
  end
  colors_file:close()

  -- Set up lualine colors
  local colorscheme = {
    normal = {
      a = { fg = colors[1], bg = colors[5] },
      b = { fg = colors[8], bg = colors[1] },
      c = { fg = colors[8], bg = colors[1] },
    },
    insert = { a = { fg = colors[1], bg = colors[3] } },
    visual = { a = { fg = colors[1], bg = colors[4] } },
    replace = { a = { fg = colors[1], bg = colors[2] } },
  }

  require('lualine').setup {
    options = {
      theme = colorscheme,
    },
  }

  -- Set editor colors with transparent background
  vim.api.nvim_set_hl(0, "Normal", { fg = colors[8], bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors[8], bg = "NONE" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors[9], bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", underline = true }) -- Set to underline instead of solid background
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors[3], bg = "NONE" })

  -- Syntax highlighting
  vim.api.nvim_set_hl(0, "Comment", { fg = colors[9] })
  vim.api.nvim_set_hl(0, "Constant", { fg = colors[3] })
  vim.api.nvim_set_hl(0, "String", { fg = colors[4] })
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors[5] })
  vim.api.nvim_set_hl(0, "Function", { fg = colors[6] })
  vim.api.nvim_set_hl(0, "Statement", { fg = colors[7] })
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors[10] })
  vim.api.nvim_set_hl(0, "Type", { fg = colors[11] })
  vim.api.nvim_set_hl(0, "Special", { fg = colors[12] })

  -- UI elements
  vim.api.nvim_set_hl(0, "Pmenu", { fg = colors[8], bg = colors[2] })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors[1], bg = colors[5] })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = colors[2] })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors[5] })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors[8], bg = colors[2] })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors[9], bg = colors[2] })
  vim.api.nvim_set_hl(0, "TabLine", { fg = colors[9], bg = colors[2] })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors[2] })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors[8], bg = colors[5] })

  -- Git signs
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors[3], bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors[4], bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors[2], bg = "NONE" })

  -- Diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors[2] })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors[3] })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors[4] })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors[5] })

  -- Search
  vim.api.nvim_set_hl(0, "Search", { fg = colors[1], bg = colors[3] })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = colors[1], bg = colors[5] })

  -- Diff
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors[3], bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = colors[4], bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors[2], bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiffText", { fg = colors[5], bg = "NONE" })

  -- You can add more highlight groups as needed
end

return M


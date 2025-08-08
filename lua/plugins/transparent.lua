return {
  "xiyaowong/transparent.nvim",
  config = function()
    -- Optional: Configure the plugin
    require("transparent").setup({
      groups = { -- Default groups to make transparent
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
      },
      extra_groups = { -- Add additional groups like plugin panels
        "NormalFloat", -- For plugins like Lazy, Mason, LspInfo
        "NvimTreeNormal", -- For NvimTree
      },
      exclude_groups = {}, -- Groups you don't want to clear
      on_clear = function() end, -- Optional callback after clearing
    })

    -- Optional: Enable transparency on startup
    vim.cmd([[TransparentEnable]])
  end,
}
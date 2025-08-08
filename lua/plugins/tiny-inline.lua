return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      signs = {
        left = "", -- No background
        right = "", -- No background
        diag = "   ●", -- Diagnostic sign
        arrow = "", -- Adjusted arrow (trimmed spaces for clarity)
        up_arrow = "",
        vertical = "│",
        vertical_end = "└",
      },
      blend = {
        factor = 0, -- Ensure fully transparent background
      },
      diagnostics = {
        virtual_text = true, -- Enable inline error messages
        underline = true, -- Underline errors
        signs = true, -- Show signs in the gutter
        update_in_insert = true, -- Update diagnostics while typing
        priority = 100, -- High priority for diagnostics
      },
    })
    -- Override Neovim's default diagnostics to avoid conflicts
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = true,
      update_in_insert = true,
    })
    -- Set transparent background for all diagnostic highlights
    vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextError", { bg = "NONE", fg = "#ff0000" })
    vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextWarn", { bg = "NONE", fg = "#ff8800" })
    vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextInfo", { bg = "NONE", fg = "#00ff00" })
    vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextHint", { bg = "NONE", fg = "#00ffff" })
      end,
}

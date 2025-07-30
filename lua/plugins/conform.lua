-- ~/.config/nvim/lua/plugins/formatter.lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = { "mason.nvim" }, -- Untuk mengelola formatter
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        php = { "php_cs_fixer" }, -- Untuk PHP dan Laravel
        lua = { "stylua" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true, -- Gunakan LSP jika formatter tidak tersedia
        timeout_ms = 1000,   -- Timeout untuk formatting
      },
      formatters = {
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = { "fix", "$FILENAME", "--rules=@PSR12" },
          stdin = false,
        },
      },
    },
    init = function()
      -- Registrasi formatter untuk LazyVim
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
      })
    end,
  },
}
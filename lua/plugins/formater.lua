-- File: ~/.config/nvim/lua/plugins/formatter.lua
-- Plugin untuk pemformatan otomatis file JavaScript, JSX, TypeScript, TSX, PHP, Laravel Blade, HTML, dan CSS

return {
  {
    "mhartington/formatter.nvim",
    event = { "BufWritePost" },
    config = function()
      local util = require("formatter.util")
      require("formatter").setup({
        filetype = {
          javascript = {
            require("formatter.filetypes.javascript").prettier,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
          },
          typescript = {
            require("formatter.filetypes.typescript").prettier,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
          },
          html = {
            require("formatter.filetypes.html").prettier,
          },
          css = {
            require("formatter.filetypes.css").prettier,
          },
          php = {
            function()
              -- Gunakan PHP CS Fixer atau Pint untuk PHP
              return {
                exe = "php-cs-fixer", -- Ganti dengan "pint" jika menggunakan Pint
                args = {
                  "fix",
                  "--rules=@PSR12,semicolon_after_instruction,blank_line_after_opening_tag,spaces_around_operators",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          },
          ["blade.php"] = {
            function()
              -- Laravel Blade menggunakan Pint (atau PHP CS Fixer)
              return {
                exe = "php-cs-fixer", -- Alternatif: php-cs-fixer
                args = {
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          },
        },
      })

      -- Keymaps untuk pemformatan manual
      vim.keymap.set("n", "<leader>fmn", "<cmd>Format<cr>", { desc = "Format file" })
      vim.keymap.set("n", "<leader>fMn", "<cmd>FormatWrite<cr>", { desc = "Format and save file" })
    end,
  },
}
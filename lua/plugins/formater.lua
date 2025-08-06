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
              return {
                exe = "php-cs-fixer", -- Ganti dengan "pint" jika menggunakan Pint
                args = {
                  "fix",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          },
        },
      })

      -- Nonaktifkan format otomatis LazyVim (conform.nvim)
      vim.g.lazyvim_format_on_save = false

      -- Keymaps untuk pemformatan manual
      vim.keymap.set("n", "<leader>fmn", "<cmd>Format<cr>", { desc = "Format file" })
      vim.keymap.set("n", "<leader>fMn", "<cmd>FormatWrite<cr>", { desc = "Format and save file" })

      -- Format otomatis saat menyimpan
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true }),
        callback = function()
          vim.cmd("FormatWrite")
        end,
      })
    end,
  },
  -- Nonaktifkan conform.nvim untuk menghindari konflik
  {
    "stevearc/conform.nvim",
    enabled = false,
  },
}
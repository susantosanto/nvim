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
            -- Tambahkan opsi untuk prettier agar menambahkan titik koma
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--semi", -- Pastikan titik koma ditambahkan
                  "--trailing-comma", "all", -- Tambahkan koma pada trailing
                },
                stdin = true,
              }
            end,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--semi",
                  "--trailing-comma", "all",
                },
                stdin = true,
              }
            end,
          },
          typescript = {
            require("formatter.filetypes.typescript").prettier,
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--semi",
                  "--trailing-comma", "all",
                },
                stdin = true,
              }
            end,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--semi",
                  "--trailing-comma", "all",
                },
                stdin = true,
              }
            end,
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
                exe = "php-cs-fixer",
                args = {
                  "fix",
                  "--rules=@PSR12,semicolon_after_instruction,spaces_around_operators",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          },
          ["blade.php"] = {
            function()
              return {
                exe = "php-cs-fixer",
                args = {
                  "fix",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          },
        },
        -- Opsi global untuk menangani error
        logging = true,
        log_level = vim.log.levels.WARN,
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
          -- Periksa apakah ada diagnostik error sebelum format
          local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          if #diagnostics == 0 then
            vim.cmd("FormatWrite")
          else
            print("Format dibatalkan: Terdapat error sintaks. Perbaiki kode terlebih dahulu.")
          end
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
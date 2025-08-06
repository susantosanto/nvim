return {
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require("mini.files").setup({
        -- Konfigurasi default mini.files
        windows = {
          preview = true, -- Tampilkan preview file
          width_preview = 50, -- Lebar preview
        },
      })

      -- Keymap untuk membuka mini.files di direktori file saat ini
      vim.keymap.set("n", "<leader>fm", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end, { desc = "Open mini.files (current file dir)" })

      -- Keymap untuk membuka mini.files di CWD
      vim.keymap.set("n", "<leader>fM", function()
        require("mini.files").open(vim.loop.cwd(), true)
      end, { desc = "Open mini.files (CWD)" })

      -- Keymap lokal untuk split di mini.files
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "v", function()
            require("mini.files").go_in({ close_on_select = true, split = "vertical" })
            vim.cmd("wincmd l") -- Pindah ke window baru
          end, { buffer = buf_id, desc = "Open file in vertical split" })
          vim.keymap.set("n", "h", function()
            require("mini.files").go_in({ close_on_select = true, split = "horizontal" })
            vim.cmd("wincmd j") -- Pindah ke window baru
          end, { buffer = buf_id, desc = "Open file in horizontal split" })
        end,
      })
    end,
  },
}
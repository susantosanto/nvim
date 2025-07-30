return {
  "CRAG666/code_runner.nvim",
  event = "BufReadPost", -- Lazy load saat membuka file
  dependencies = { "nvim-lua/plenary.nvim" }, -- Dependensi yang diperlukan
  config = function()
    require("code_runner").setup({
      filetype = {
        python = "python3 -u $fileName",
        javascript = "node $fileName",
        typescript = "ts-node $fileName",
        lua = "lua $fileName",
        sh = "bash $fileName",
        html = "start $fileName", -- Buka HTML di browser default (Windows)
      },
      mode = "term", -- Jalankan di terminal Neovim
      focus = true, -- Fokus ke terminal saat menjalankan
      startinsert = false, -- Jangan masuk ke mode insert di terminal
      term = {
        position = "bot", -- Terminal di bagian bawah
        size = 15, -- Tinggi terminal
      },
    })

    -- Keybinding tanpa WhichKey
    vim.keymap.set("n", "<leader>rr", "<cmd>RunCode<cr>", { desc = "Run File" })
    vim.keymap.set("v", "<leader>rs", "<cmd>RunCode<cr>", { desc = "Run Selected Code" })
  end,
}
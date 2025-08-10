return {
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost", -- Load setelah buffer dibaca
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Opsional, untuk dukungan bahasa lebih baik
    config = function()
      require("Comment").setup({
        -- Konfigurasi default sudah cukup baik, tapi bisa dikustom
        padding = true, -- Tambah spasi setelah tanda komentar
        sticky = true,  -- Kursor tetap di tempat setelah toggle
        ignore = nil,   -- Jangan abaikan baris kosong

        -- Shortcut untuk komentar
        toggler = {
          line = "<leader>cb",  -- Toggle komentar baris (line comment)
          block = "<leader>cB", -- Toggle komentar blok (block comment, jika didukung bahasa)
        },
        opleader = {
          line = "<leader>cb",  -- Sama seperti toggler, untuk operator mode
          block = "<leader>cB",
        },
        extra = {
          above = "<leader>cO", -- Tambah baris komentar di atas
          below = "<leader>co", -- Tambah baris komentar di bawah
          eol = "<leader>cA",   -- Tambah komentar di akhir baris
        },
      })
    end,
  },
}
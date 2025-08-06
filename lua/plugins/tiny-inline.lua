return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach", -- Ubah ke LspAttach agar dimuat saat LSP aktif
  priority = 1000, -- Pastikan dimuat lebih awal
  config = function()
    require("tiny-inline-diagnostic").setup({
      signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "",
        up_arrow = "",
        vertical = " │",
        vertical_end = " └",
      },
      blend = {
        factor = 0.22,
      },
      diagnostics = {
        virtual_text = true, -- Aktifkan virtual text untuk tiny-inline-diagnostic
        underline = true, -- Aktifkan garis bawah
        signs = true, -- Aktifkan tanda di gutter
      },
    })
    -- Nonaktifkan virtual_text default Neovim
    vim.diagnostic.config({ virtual_text = false })
  end,
}
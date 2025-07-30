return {
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" }, -- Muat plugin saat masuk ke mode insert
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Pastikan Treesitter sebagai dependensi
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "typescriptreact", "javascriptreact", "tsx", "jsx" }, -- Nonaktifkan autopairs untuk TSX/JSX
        enable_check_bracket_line = false, -- Cegah konflik dengan tag penutup
        fast_wrap = {
          map = '<M-e>', -- Keymap untuk fast wrap (opsional)
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
        },
      })

      -- Integrasi dengan nvim-treesitter (opsional, untuk memastikan kompatibilitas)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      -- Contoh aturan tambahan (opsional, jika Anda ingin menyesuaikan)
      npairs.add_rules({
        Rule("<", ">", { "typescriptreact", "javascriptreact" })
          :with_pair(ts_conds.is_ts_node({ "jsx_element", "jsx_self_closing_element" })),
      })
    end,
  },
}
return {
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = { "stevearc/dressing.nvim" }, -- untuk UI yang lebih baik
    config = function()
      require("legendary").setup({
        -- Konfigurasi tambahan (opsional)
        select_prompt = "Pilih perintah atau keymap:",
        include_builtin = true, -- Sertakan keymaps bawaan Neovim
        include_legendary_cmds = true, -- Sertakan perintah legendary.nvim
      })
    end,
  },
}
-- File: ~/.config/nvim/lua/plugins/buffer_and_navigation.lua
-- Plugin untuk manajemen buffer dan navigasi: vim-bufkill, qclose.nvim, accelerated-jk.nvim

return {
  -- Plugin: qpkorr/vim-bufkill
  {
    "qpkorr/vim-bufkill",
    event = "VeryLazy",
    keys = {
      { "<leader>bk", "<cmd>BD<cr>", desc = "Delete buffer without closing window" },
      { "<leader>bw", "<cmd>BW<cr>", desc = "Wipeout buffer" },
      { "<leader>bu", "<cmd>BUN<cr>", desc = "Unload buffer" },
    },
  },

}
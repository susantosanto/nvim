return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Konfigurasi tanda untuk setiap tingkat severity
      signs = {
        error = "",
        warning = "",
        hint = "󰌶",
        information = "󰋽",
      },
      use_diagnostic_signs = true, -- Gunakan tanda diagnostik bawaan Neovim
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      
      -- Keymap untuk toggle Trouble panel
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true, desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true, desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true, desc = "Quickfix List" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true, desc = "Location List" })
    end,
  },
}
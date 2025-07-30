return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client, bufnr)
        -- Nonaktifkan format oleh tsserver, gunakan prettier jika ada
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Keymaps buffer-lokal
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "<leader>lo", "<cmd>TSToolsOrganizeImports<cr>", vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
        vim.keymap.set("n", "<leader>lO", "<cmd>TSToolsSortImports<cr>", vim.tbl_extend("force", opts, { desc = "Sort Imports" }))
        vim.keymap.set("n", "<leader>lm", "<cmd>TSToolsAddMissingImports<cr>", vim.tbl_extend("force", opts, { desc = "Add Missing Imports" }))
        vim.keymap.set("n", "<leader>lf", "<cmd>TSToolsFixAll<cr>", vim.tbl_extend("force", opts, { desc = "Fix All Issues" }))
        vim.keymap.set("n", "<leader>ld", "<cmd>TSToolsGoToSourceDefinition<cr>", vim.tbl_extend("force", opts, { desc = "Go to Source Definition" }))
        vim.keymap.set("n", "<leader>lr", "<cmd>TSToolsRenameFile<cr>", vim.tbl_extend("force", opts, { desc = "Rename File" }))
      end,
      settings = {
        -- Filetypes untuk proyek React/Vite
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        -- Aktifkan penutupan tag JSX
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
        -- Pengaturan tsserver
        tsserver_file_preferences = function()
          return {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          }
        end,
        tsserver_format_options = function()
          return {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          }
        end,
        -- Dukungan untuk styled-components (opsional, hapus jika tidak digunakan)
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
      },
    },
  },
}
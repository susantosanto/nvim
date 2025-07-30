return {
    "nvim-lua/plenary.nvim", -- Dependency for none-ls
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local sources = {}
            if vim.fn.executable("misspell") == 1 then
                table.insert(sources, null_ls.builtins.diagnostics.misspell)
            end
            null_ls.setup({
                sources = sources,
            })
        end,
    },
}
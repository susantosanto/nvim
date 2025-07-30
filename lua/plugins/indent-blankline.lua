return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│", tab_char = "│" },
            whitespace = { remove_blankline_trail = true },
            scope = { enabled = true, show_start = false, show_end = false },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
            vim.api.nvim_set_hl(0, "IblIndent", { fg = "#586e75" })
        end,
    },
}
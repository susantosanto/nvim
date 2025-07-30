return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({
      enable = true,
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact", -- untuk file .tsx
        "tsx",
        "jsx",
      },
    })
  end,
}

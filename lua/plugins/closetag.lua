return {
  {
    "alvan/vim-closetag",
    config = function()
      vim.g.closetag_filetypes = "html,javascriptreact,typescriptreact"
      vim.g.closetag_xhtml_filetypes = "xhtml,javascriptreact,typescriptreact"
    end,
  },
}
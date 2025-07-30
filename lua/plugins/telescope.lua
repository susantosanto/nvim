return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ahmedkhalf/project.nvim",
  },
  config = function()
    require("telescope").setup({})
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = { ".git", "Makefile", "package.json" },
    })
  end,
}
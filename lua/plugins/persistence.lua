-- lua/plugins/persistence.lua
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.expand("~\\AppData\\Local\\nvim-data\\sessions\\"), -- Adjusted for Windows
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    pre_save = function()
      -- Sanitize session file name to avoid invalid characters
      local session_name = vim.fn.getcwd():gsub("[^%w%-_]", "_") .. ".vim"
      return session_name
    end,
  },
  config = function(_, opts)
    require("persistence").setup(opts)
    -- Disable session saving for problematic directories
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = vim.api.nvim_create_augroup("Persistence", { clear = true }),
      callback = function()
        local cwd = vim.fn.getcwd()
        -- Skip saving sessions for problematic directories
        if cwd:match("Set%-PSReadLineOption") or cwd:match("^D:") then
          return
        end
        require("persistence").save()
      end,
    })
  end,
}

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false, -- Disable suggestions by default
        auto_trigger = false, -- Disable auto-trigger
        keymap = {
          accept = "<C-g>", -- Accept suggestion with Ctrl+g (if enabled manually)
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = false }, -- Keep panel disabled
    })
    -- Disable Copilot entirely on startup
    vim.cmd("Copilot disable")
  end,
}
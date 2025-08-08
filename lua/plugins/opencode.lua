return {
  "NickvanDyke/opencode.nvim",
  dependencies = { "folke/snacks.nvim" }, -- Asumsi Anda menggunakan file explorer ini
  opts = {
    auto_register_cmp_sources = { "opencode", "buffer" }, -- Sumber completion
  },
  keys = {
    { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle OpenCode", mode = "n" },
    { "<leader>oa", function() require("opencode").ask() end, desc = "Ask OpenCode", mode = "n" },
    { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask OpenCode about selection", mode = "v" },
    { "<leader>op", function() require("opencode").select_prompt() end, desc = "Select prompt", mode = { "n", "v" } },
    { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
    { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
    { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Scroll messages up" },
    { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Scroll messages down" },
  },
}
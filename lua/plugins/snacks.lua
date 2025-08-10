return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true,
        auto_close = false,
        follow_file = true,
        tree = true,
        git_status = true,
        git_untracked = true,
        diagnostics = true,
        watch = true,
        layout = { preset = "sidebar", preview = false },
        win = {
          list = {
            keys = {
              ["<BS>"] = "explorer_up",
              ["l"] = "confirm",
              ["h"] = "explorer_close",
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open",
              ["P"] = "toggle_preview",
              ["y"] = { "explorer_yank", mode = { "n", "x" } },
              ["p"] = "explorer_paste",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["<leader>/"] = "picker_grep",
              ["<c-t>"] = "terminal",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
              ["]g"] = "explorer_git_next",
              ["[g"] = "explorer_git_prev",
              ["]d"] = "explorer_diagnostic_next",
              ["[d"] = "explorer_diagnostic_prev",
            },
          },
        },
      },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            layout = { preset = "sidebar", preview = false },
          },
        },
      },
      notifier = {
        enabled = true,
        timeout = 2500, -- Slightly faster timeout for a snappier feel
        style = "modern", -- Professional and modern notification style
      },
      -- Enhanced visual styling for a polished look
      ui = {
        border = "rounded", -- Modern rounded borders
        icons = {
          folder = " ",
          file = " ",
          git = " ",
          diagnostic = " ",
        },
        highlights = {
          SnacksExplorerBorder = { fg = "#3b4261" }, -- Subtle, professional border color
          SnacksExplorerActive = { bg = "#2e3440", fg = "#eceff4" }, -- Modern Nordic theme
          SnacksPickerHeader = { fg = "#88c0d0", bold = true }, -- Clean, vibrant headers
        },
      },
    },
    keys = {
      { "<leader><space>", function() require("snacks.picker").smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() require("snacks.picker").buffers() end, desc = "Buffers" },
      { "<leader>/", function() require("snacks.picker").grep() end, desc = "Grep" },
      { "<leader>e", function() require("snacks.explorer")() vim.schedule(function() vim.api.nvim_feedkeys(".", "n", false) end) end, desc = "Focus File Explorer" },
      { "<leader>ff", function() require("snacks.picker").files() end, desc = "Find Files" },
    },
  },
}
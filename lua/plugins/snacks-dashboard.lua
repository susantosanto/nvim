return {
  {
    "folke/snacks.nvim",
    priority = 1000, -- Load early for instant dashboard
    lazy = false, -- Ensure immediate startup
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat({
            "",
            "  Santo Studio Code: My Neovim Workspace  ",
            "",
          }, "\n"),
          footer = "Next Millionaire - Tife and Fuad",
          keys = {
            {
              icon = "󰍉 ",
              key = "f",
              desc = "Explore Files",
              action = function()
                local ok, _ = pcall(require("telescope.builtin").find_files, { hidden = true, no_ignore = true, file_ignore_patterns = { ".git/", "node_modules/" } })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end,
            },
            { icon = "󰈤 ", key = "n", desc = "Create File", action = ":ene | startinsert" },
            {
              icon = "󰅍 ",
              key = "r",
              desc = "Recent Files",
              action = function()
                local ok, _ = pcall(require("telescope.builtin").oldfiles, { only_cwd = true })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end,
 
            },
            {
              icon = "󰮗 ",
              key = "g",
              desc = "Grep Project",
              action = function()
                local ok, _ = pcall(require("telescope.builtin").live_grep, { vimgrep_arguments = { "rg", "--hidden", "--no-ignore", "--glob", "!.git/" } })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end,
            },
            {
              icon = "󰒓 ",
              key = "c",
              desc = "Edit Config",
              action = function()
                local ok, _ = pcall(require("telescope.builtin").find_files, { cwd = vim.fn.stdpath("config"), hidden = true, file_ignore_patterns = { ".git/" } })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end,
            },
            {
              icon = " ",
              key = "s",
              desc = "Restore Session",
              action = function()
                local ok, persistence = pcall(require, "persistence")
                if ok then
                  persistence.load()
                else
                  vim.notify("Persistence unavailable", vim.log.levels.WARN)
                end
              end,
            },
            {
              icon = "󰊢 ",
              key = "b",
              desc = "Git Browser",
              action = function()
                local ok, snacks = pcall(require, "snacks")
                if ok and snacks.gitbrowse then
                  snacks.gitbrowse()
                else
                  vim.notify("Snacks gitbrowse unavailable", vim.log.levels.WARN)
                end
              end,
            },
            {
              icon = "󰎟 ",
              key = "N",
              desc = "GitHub Alerts",
              action = function() vim.ui.open("https://github.com/notifications") end,
            },
            {
              icon = "󰒲 ",
              key = "l",
              desc = "Manage Plugins",
              action = ":Lazy",
              enabled = function() return package.loaded.lazy ~= nil end,
            },
            { icon = "󰅖 ", key = "q", desc = "Exit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", padding = 0, col = 1, width = 50, align = "center" },
          { icon = " ", title = "Recent Files", section = "recent_files", padding = 1, col = 1, width = 50 },
          { icon = " ", title = "Projects", section = "projects", padding = 1, col = 1, width = 50 },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              local ok, snacks = pcall(require, "snacks")
              return ok and snacks.git and snacks.git.get_root and snacks.git.get_root() ~= nil
            end,
            cmd = "powershell -Command \"if (Get-Command git -ErrorAction SilentlyContinue) { git status --short --branch --renames } else { Write-Output 'Git not found' }\"",
            height = 3,
            padding = 1,
            ttl = 5 * 60,
            col = 1,
            width = 50,
          },
          { section = "keys", gap = 0, padding = 0, col = 1, width = 50 },
          { section = "startup", icon = "🚀 ", title = "Startup", padding = 0, col = 1, width = 50 },
        },
        width = 50,
        row = nil,
        col = nil,
        pane_gap = 0,
        border = "none",
        formats = {
          icon = function(item) return { item.icon or "", width = 2, hl = "SnacksDashboardIcon" } end,
          desc = function(item) return { item.desc or "", width = 24, hl = "SnacksDashboardDesc" } end,
          key = function(item) return { "[" .. item.key .. "]", hl = "SnacksDashboardKey" } end,
        },
        highlights = {
          SnacksDashboardIcon = { fg = "#6ab0f3" },
          SnacksDashboardDesc = { fg = "#ffffff" },
          SnacksDashboardKey = { fg = "#ff8f88", bold = true },
          SnacksDashboardHeader = { fg = "#ffffff", bold = true, italic = true },
          SnacksDashboardBackground = { bg = "#1a1b26" },
        },
      },
      notifier = {
        enabled = true,
        timeout = 1000,
        style = "minimal",
        border = "none",
        position = "top-right",
        highlight = { fg = "#ffffff", bg = "#2a2b3a" },
      },
      picker = {
        enabled = true,
        layout = { preset = "cursor", preview = false },
        theme = "cursor",
        highlights = {
          SnacksPickerBorder = { fg = "#44475a" },
          SnacksPickerBackground = { bg = "#1a1b26" },
        },
      },
      indent = { enabled = true, highlight = "Comment" },
      scope = { enabled = true },
      bufdelete = { enabled = true },
      ui = {
        border = "none",
        icons = {
          folder = "󰪶 ",
          file = "󰈤 ",
          git = "󰊢 ",
          diagnostic = "󰅚 ",
          active = "󰐀 ",
        },
        highlights = {
          SnacksUIBorder = { fg = "#44475a" },
          SnacksUIActive = { bg = "#2a2b3a", fg = "#ffffff" },
          SnacksUISelection = { bg = "#6ab0f3", fg = "#1a1b26" },
        },
      },
    },
    keys = {
      { "<leader>dd", function() require("snacks").dashboard() end, desc = "Open Dashboard" },
    },
  },
}
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
          -- Minimal, elegant header with subtle branding
          header = table.concat({
            "",
            "  Santo Studio Code: My Neovim Workspace  ",
            "",
          }, "\n"),
          -- Curated, professional keymaps with refined icons
          keys = {
            { icon = "󰍉 ", key = "f", desc = "Explore Files", action = function()
                local ok, _ = pcall(require("telescope.builtin").find_files, { hidden = true, no_ignore = true, file_ignore_patterns = { ".git/", "node_modules/" } })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end },
            { icon = "󰈤 ", key = "n", desc = "Create File", action = ":ene | startinsert" },
            { icon = "󰅍 ", key = "r", desc = "Recent Files", action = function()
                local ok, _ = pcall(require("telescope.builtin").oldfiles, { only_cwd = true })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end },
            { icon = "󰮗 ", key = "g", desc = "Grep Project", action = function()
                local ok, _ = pcall(require("telescope.builtin").live_grep, { vimgrep_arguments = { "rg", "--hidden", "--no-ignore", "--glob", "!.git/" } })
                if not ok then vim.notify("Telescope unavailable", vim.log.levels.WARN) end
              end },
            { icon = "󰒓 ", key = "c", desc = "Edit Config", action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config'), hidden = true, file_ignore_patterns = { '.git/' } })" },
            { icon = "󰊢 ", key = "b", desc = "Git Browser", action = function() require("snacks").gitbrowse() end },
            { icon = "󰎟 ", key = "N", desc = "GitHub Alerts", action = function() vim.ui.open("https://github.com/notifications") end },
            { icon = "󰒲 ", key = "l", desc = "Manage Plugins", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = "󰅖 ", key = "q", desc = "Exit", action = ":qa" },
          },
        },
        -- Ultra-sleek single-column layout
        sections = {
          { section = "header", padding = 0, col = 1, width = 40 },
          { section = "keys", gap = 0, padding = 0, col = 1, width = 40 },
          { section = "startup", padding = 0, col = 1, width = 40 },
        },
        -- Refined, professional dashboard styling
        width = 40, -- Compact and focused
        row = nil, -- Auto-center vertically
        col = nil, -- Auto-center horizontally
        pane_gap = 0, -- Seamless integration
        border = "none", -- Borderless for a clean, modern aesthetic
        formats = {
          icon = function(item) return { item.icon or "", width = 2, hl = "SnacksDashboardIcon" } end,
          desc = function(item) return { item.desc or "", width = 14, hl = "SnacksDashboardDesc" } end,
          key = function(item) return { "[" .. item.key .. "]", hl = "SnacksDashboardKey" } end,
        },
        highlights = {
          SnacksDashboardIcon = { fg = "#6ab0f3" }, -- Vibrant sky blue for icons
          SnacksDashboardDesc = { fg = "#ffffff" }, -- Pure white for clarity
          SnacksDashboardKey = { fg = "#ff8f88", bold = true }, -- Soft coral for keybindings
          SnacksDashboardHeader = { fg = "#ffffff", bold = true, italic = true }, -- Elegant italicized header
          SnacksDashboardBackground = { bg = "#1a1b26" }, -- Deep, modern navy background
        },
      },
      notifier = {
        enabled = true,
        timeout = 1000, -- Swift, unobtrusive notifications
        style = "minimal",
        border = "none", -- Borderless notifications
        position = "top-right", -- Sleek top-right placement
        highlight = { fg = "#ffffff", bg = "#2a2b3a" }, -- Subtle contrast
      },
      picker = {
        enabled = true,
        layout = { preset = "cursor", preview = false }, -- Cursor-focused picker for precision
        theme = "cursor", -- Minimalist theme
        highlights = {
          SnacksPickerBorder = { fg = "#44475a" }, -- Subtle border
          SnacksPickerBackground = { bg = "#1a1b26" }, -- Matching dashboard background
        },
      },
      indent = { enabled = true, highlight = "Comment" },
      scope = { enabled = true },
      bufdelete = { enabled = true },
      ui = {
        border = "none", -- Borderless UI for elegance
        icons = {
          folder = "󰪶 ",
          file = "󰈤 ",
          git = "󰊢 ",
          diagnostic = "󰅚 ",
          active = "󰐀 ", -- Unique active indicator
        },
        highlights = {
          SnacksUIBorder = { fg = "#44475a" }, -- Minimal border color
          SnacksUIActive = { bg = "#2a2b3a", fg = "#ffffff" }, -- Clean, active highlight
          SnacksUISelection = { bg = "#6ab0f3", fg = "#1a1b26" }, -- Vibrant selection
        },
      },
    },
    keys = {
      { "<leader>dd", function() require("snacks").dashboard() end, desc = "Open Dashboard" },
    },
  },
}
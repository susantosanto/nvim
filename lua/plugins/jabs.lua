return {
  {
    "matbme/JABS.nvim",
    event = "BufReadPost", -- Load after a buffer is read
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for file icons
    config = function()
      require("jabs").setup({
        -- Window options
        position = { "center", "center" }, -- Center the window for a modern look
        relative = "editor", -- Position relative to the editor
        clip_popup_size = true, -- Clip popup size to editor size
        width = 60, -- Slightly narrower window
        height = 15, -- Moderate height
        border = "rounded", -- Rounded border for aesthetics
        offset = {
          top = 2,
          bottom = 2,
          left = 2,
          right = 2,
        },

        -- Buffer options
        sort_mru = true, -- Sort buffers by most recently used
        split_filename = true, -- Show path and filename separately
        split_filename_path_width = 20, -- Width for path column
        use_devicons = true, -- Use nvim-web-devicons for file icons

        -- Preview window options
        preview_position = "top", -- Preview above the main window
        preview = {
          width = 50,
          height = 20,
          border = "rounded",
        },

        -- Highlight groups (use defaults for simplicity)
        highlight = {
          current = "Title",
          hidden = "StatusLineNC",
          split = "WarningMsg",
          alternate = "StatusLine",
        },

        -- Symbols (customize for clarity)
        symbols = {
          current = "➤", -- Current buffer
          split = "↔", -- Buffer in split
          alternate = "↻", -- Alternate buffer
          hidden = "·", -- Hidden buffer
          locked = "🔒", -- Locked buffer
          ro = "📖", -- Read-only buffer
          edited = "✎", -- Edited buffer
          terminal = "⌨", -- Terminal buffer
          default_file = "📄", -- Default file icon
          terminal_symbol = ">_", -- Terminal symbol
        },

        -- Custom keymaps to avoid conflicts
        keymap = {
          close = "<leader>bc", -- Close buffer (buffer delete)
          jump = "<CR>", -- Jump to buffer (default)
          h_split = "<leader>bh", -- Horizontal split (buffer horizontal)
          v_split = "<leader>bv", -- Vertical split (buffer vertical)
          preview = "<leader>bp", -- Preview buffer (buffer preview)
        },
      })

      -- Additional keymap to open JABS
      vim.keymap.set("n", "<leader>bb", "<cmd>JABSOpen<CR>", { desc = "Open JABS buffer switcher", silent = true, noremap = true })
    end,
  },
}
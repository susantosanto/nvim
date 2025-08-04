return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

 {
  "b0o/incline.nvim",
  event = { "BufReadPost" },
  opts = {
    highlight = {
      groups = {
        InclineNormal = {
          guibg = "CursorLine", -- Link background to theme's CursorLine
          guifg = "fg",         -- Use theme's default foreground
        },
        InclineNormalNC = {
          guibg = "NormalNC",   -- Link background to theme's non-current window
          guifg = "Comment",    -- Use theme's comment color for inactive windows
        },
      },
    },
    hide = {
      cursorline = true,      -- Hide cursorline in incline bar
      focused_win = false,    -- Show incline in all windows
      only_win = false,       -- Show incline even with multiple windows
    },
    window = {
      margin = {
        vertical = 0,
        horizontal = 1,
      },
      zindex = 29,            -- Below zen-mode’s default (40)
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      return {
        { filename, guifg = props.focused and "fg" or "Comment" },
      }
    end,
  },
},
  
{
    "b0o/incline.nvim",
    event = { "BufReadPost" },
    opts = {
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            group = "CursorLine",
          },
          InclineNormalNC = {
            default = true,
            group = "TermCursorNC",
          },
        },
      },
      hide = {
        cursorline = true,
      },
      window = {
        margin = {
          vertical = 0,
          horizontal = 1,
        },
        zindex = 29, -- less than zen mode defualt, 40, 40 - 10
      },
    },
  },
  -- Simplified Incline Statusline with Dynamic Icon Colors
{
  "b0o/incline.nvim",
  event = { "BufReadPost" },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- For file type icons
  init = function()
    -- Define highlight groups dynamically to link to theme's groups
    vim.api.nvim_set_hl(0, "InclineNormal", { link = "CursorLine" })
    vim.api.nvim_set_hl(0, "InclineNormalNC", { link = "NormalNC" })
  end,
  opts = {
    highlight = {
      groups = {
        InclineNormal = "InclineNormal",   -- Link to custom highlight group
        InclineNormalNC = "InclineNormalNC", -- Link to custom highlight group
      },
    },
    hide = {
      cursorline = true,      -- Hide cursorline in incline bar
      focused_win = false,    -- Show incline in all windows
      only_win = false,       -- Show incline even with multiple windows
    },
    window = {
      margin = {
        vertical = 0,
        horizontal = 1,
      },
      zindex = 29,            -- Below zen-mode’s default (40)
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local filetype = vim.bo[props.buf].filetype
      local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, filetype, { default = true })
      return {
        { icon .. " ", guifg = icon_color }, -- Icon with nvim-web-devicons color
        { filename, guifg = props.focused and vim.api.nvim_get_hl(0, { name = "Normal" }).fg or vim.api.nvim_get_hl(0, { name = "Comment" }).fg }, -- Dynamic fg
      }
    end,
  },
},


  -- statusline
  {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local lualine = require("lualine")
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 3, -- Just the filename
            symbols = { modified = "●", readonly = " 󰌾 " },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
},

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
}
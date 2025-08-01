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
    dependencies = { "craftzdog/solarized-osaka.nvim", "nvim-web-devicons" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup({ variant = "dark" })
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guifg = colors.cyan600, gui = "bold" }, -- Remove base02 background
            InclineNormalNC = { guifg = colors.blue400, guibg = colors.base03, gui = "none" },
            InclineSeparator = { guifg = colors.magenta600, guibg = colors.base03, gui = "bold" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 }, padding = 2, zindex = 60 },
        hide = { cursorline = true, focused_win = false },
        render = function(props)
          local buf = props.buf
          local bufname = vim.api.nvim_buf_get_name(buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then filename = "[No Name]" end
          if vim.bo[buf].modified then filename = "● " .. filename end

          local git_status = vim.b.gitsigns_status_dict or {}
          local branch = git_status.head and ("   " .. git_status.head) or ""

          local mode = ({ n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK", c = "COMMAND", t = "TERMINAL" })[vim.fn.mode(1)] or "UNKNOWN"
          local mode_color = { NORMAL = colors.green300, INSERT = colors.red600, VISUAL = colors.yellow700, COMMAND = colors.cyan700, TERMINAL = colors.magenta700 }

          local mode_padding = 2
          local item_padding = 2

          local devicon, devcolor = require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo[buf].filetype, { default = true })

          -- Center mode text within its block
          local mode_text = mode
          local block_width = #mode_text + 2
          local internal_padding = math.floor((block_width - #mode_text) / 2)

          return {
            { string.rep(" ", internal_padding) .. mode_text .. string.rep(" ", internal_padding), guibg = colors.green300, guifg = colors.base02, gui = "bold" }, -- Centered in block
            { string.rep(" ", mode_padding), guibg = colors.base03, guifg = colors.base3 },
            { devicon and (devicon .. " ") or "", guibg = colors.base03, guifg = devcolor }, -- Icon color based on file type
            { filename, guibg = colors.base03, guifg = colors.base0, gui = vim.bo[buf].modified and "italic" or "none" },
            { string.rep(" ", item_padding), guibg = colors.base03, guifg = colors.base3 },
            { branch, guibg = colors.teal600, guifg = colors.base3, gui = "italic" },
          }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
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
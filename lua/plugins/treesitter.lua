-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag", -- Autoclose and autorename tags
      "windwp/nvim-autopairs",  -- Autopairs for brackets, quotes, etc.
      "nvim-treesitter/nvim-treesitter-textobjects", -- Text objects navigation
    },
    config = function()
      -- Treesitter configuration
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        -- Ensure installed parsers for fullstack web and PHP/Laravel
        ensure_installed = {
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "php",
          "phpdoc",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "php" }, -- Enable regex highlighting for PHP
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.inner",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.inner",
            },
          },
        },
        -- Autotag configuration
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "tsx",
            "jsx",
            "xml",
            "php",
            "markdown",
			"prisma"
          },
        },
      })

      -- Map TSX and JSX to appropriate parsers
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
      parser_config.jsx = { "javascript", "javascriptreact" }

      -- Autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        per_filetype = {
          ["html"] = { enable_close = true },
          ["php"] = { enable_close = true },
          ["tsx"] = { enable_close = true },
          ["jsx"] = { enable_close = true },
        },
      })

      -- Autopairs setup
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        check_ts = true, -- Integrate with treesitter
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          php = { "string" },
        },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      -- Integrate autopairs with treesitter
      local ts_conds = require("nvim-autopairs.ts-conds")
      autopairs.add_rules({
        require("nvim-autopairs.rule")("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        require("nvim-autopairs.rule")("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
      })
    end,
  },
}
return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "tailwindcss" })
		end,
	},
	-- {
	-- 	"catgoose/nvim-colorizer.lua",
	-- 	opts = {
	-- 		user_default_options = {
	-- 			tailwind = true,
	-- 		},
	-- 	},
	-- },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- original kind icon formatter
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				local lspkind = require("tailwindcss-colorizer-cmp").formatter(entry, item)
				if lspkind.kind == "XX" then
					lspkind.kind = " "
				end
				return lspkind
			end
		end,
	},

    -- tailwind-tools.lua
 {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig", -- optional
  },
  opts = {} -- your configuration
},

{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "tailwind-tools",
    "onsails/lspkind-nvim",
    -- ...
  },
  opts = function()
    return {
      -- ...
      formatting = {
        format = require("lspkind").cmp_format({
          before = require("tailwind-tools.cmp").lspkind_format
        }),
      },
    }
  end,
},
}
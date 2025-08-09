return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},

	{
		 "Tsuzat/NeoSolarized.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
	{
		'datsfilipe/vesper.nvim',
	lazy = false,
	priority = 1000,
	opts = function()
		return {
			transparent = true,
		}
	end,
},
{
	'Mofiqul/vscode.nvim',
	lazy = false,
	priority = 1000,
	opts = function()
		return {
			transparent = true,
		}
	end,
},
{
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_dark')
  end,
},
{
	"2nthony/vitesse.nvim",
	lazy = true,
	-- priority = 1000,
	dependencies = {
      "tjdevries/colorbuddy.nvim"
    },
	opts = function()
		return {
			transparent_background = true,
		}
	end,
},
{
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	opts = function()
		return {
			transparent = true,
		}
	end,
},

{ "catppuccin", enabled = false },

  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
      end,
      set_light_mode = function()
        vim.o.background = "light"
      end,
    },
  },

  {
     "folke/tokyonight.nvim",
	 lazy = true,
	 priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
      },
    },
  },

    {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
},
  {
"HoNamDuong/hybrid.nvim",
    lazy = false,
	priority = 1000,
	opts = function()
		return {
			transparent = true,
		}
	end,
},
}

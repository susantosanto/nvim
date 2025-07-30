return {
  -- laravel.nvim: Integrasi Artisan, route list, tinker
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "nvimtools/none-ls.nvim",
      "kevinhwang91/promise-async", -- Perbaiki URL repositori
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    event = { "VeryLazy" },
    keys = {
      { "<leader>la", "<cmd>Laravel artisan<cr>", desc = "Run Artisan commands" },
      { "<leader>lr", "<cmd>Laravel routes<cr>", desc = "List Laravel routes" },
      { "<leader>lt", "<cmd>Laravel tinker<cr>", desc = "Open Laravel Tinker" },
      { "<leader>lm", "<cmd>Laravel related<cr>", desc = "Find related Laravel files" },
      { "<leader>lh", "<cmd>LaravelIdeHelperCheck<cr>", desc = "Check Laravel IDE Helper" },
    },
    opts = {
      lsp_server = "intelephense",
      features = {
        null_ls = { enable = false }, -- Nonaktifkan null-ls jika menggunakan conform.nvim
      },
    },
  },

  -- phpactor/phpactor: LSP dan refactoring PHP
  {
    "phpactor/phpactor",
    ft = { "php" },
    build = ":call phpactor#Update()",
    dependencies = { "phpactor/ncm2-phpactor", "hrsh7th/nvim-cmp" },
    config = function()
      vim.keymap.set("n", "<leader>pc", "<cmd>call phpactor#ContextMenu()<cr>", { desc = "Phpactor context menu" })
      vim.keymap.set("n", "<leader>pd", "<cmd>call phpactor#GotoDefinition()<cr>", { desc = "Phpactor go to definition" })
      vim.keymap.set("n", "<leader>pr", "<cmd>call phpactor#FindReferences()<cr>", { desc = "Phpactor find references" })
      vim.keymap.set("v", "<leader>pe", "<cmd>call phpactor#ExtractMethod()<cr>", { desc = "Phpactor extract method" })
      vim.keymap.set("n", "<leader>pi", "<cmd>PHPImportClass<cr>", { desc = "Phpactor import class" })
    end,
  },

  -- haringsrob/laravel-dev-tools: Blade LSP dan generator
  {
    "haringsrob/laravel-dev-tools",
    ft = { "php", "blade" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.blade.setup({
        cmd = { "laravel-dev-generators", "lsp" },
        filetypes = { "blade" },
        root_dir = lspconfig.util.find_git_ancestor,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
      vim.keymap.set("n", "<leader>lgc", "<cmd>!php artisan make:controller<cr>", { desc = "Generate Laravel controller" })
      vim.keymap.set("n", "<leader>lgm", "<cmd>!php artisan make:model<cr>", { desc = "Generate Laravel model" })
      vim.keymap.set("n", "<leader>lgmi", "<cmd>!php artisan make:migration<cr>", { desc = "Generate Laravel migration" })
    end,
  },

  -- blade-nav.nvim: Navigasi cepat antar Blade view dan controller
  {
    "ricardoramirezr/blade-nav.nvim",
    ft = { "blade", "php" },
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      vim.keymap.set("n", "<leader>lb", "<cmd>BladeNavGoToView<cr>", { desc = "Go to Blade view" })
      vim.keymap.set("n", "<leader>lc", "<cmd>BladeNavGoToController<cr>", { desc = "Go to controller" })
    end,
  },

  -- nvim-blade: Syntax highlighting untuk Blade
  {
    "jwalton512/vim-blade",
    ft = { "blade" },
    config = function()
      vim.filetype.add({ pattern = { [".*%.blade%.php"] = "blade" } })
    end,
  },

  -- Treesitter untuk Blade
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.blade.php",
        callback = function()
          vim.opt.filetype = "blade"
        end,
      })
    end,
  },
}
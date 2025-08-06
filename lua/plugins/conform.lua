return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        php = { "php_cs_fixer" },
        ["blade.php"] = { "php_cs_fixer" }, -- Tambahkan Blade secara eksplisit
        lua = { "stylua" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },
      formatters = {
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = { "fix", "$FILENAME", "--rules=@PSR12" },
          stdin = false,
        },
        stylua = {
          command = "stylua",
          args = { "--stdin-filepath", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      -- Keymap untuk pemformatan manual
      vim.keymap.set("n", "<leader>fmn", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
    init = function()
      -- Registrasi format otomatis untuk LazyVim
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformFormat", { clear = true }),
        callback = function(args)
          require("conform").format({ bufnr = args.buf, async = true, lsp_fallback = true })
        end,
      })
    end,
  },
  -- Pastikan mason.nvim menginstal formatter
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "prettier",
        "php-cs-fixer",
        "stylua",
      })
    end,
  },
}
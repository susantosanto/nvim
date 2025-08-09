return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "emmet-ls",
        "intelephense",
        "prettier",
        "php-cs-fixer",
        "eslint_d",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        eslint = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            workingDirectory = { mode = "auto" },
            codeActionOnSave = {
              enable = true,
              mode = "all",
            },
            rulesCustomizations = {
              { rule = "no-undef", severity = "error" },
            },
            format = false,
            useESLintGlobal = true,
            nodePath = "",
          },
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
          end,
        },
        html = {},
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "tsx", "jsx" },
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true,
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        intelephense = {
          settings = {
            intelephense = {
              files = {
                associations = { "*.php", "*.blade.php" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {},
        automatic_installation = true,
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup(opts.servers[server_name] or {})
        end,
      })

      -- Konfigurasi diagnostik bawaan Neovim untuk menampilkan virtual text dengan tanda hijau untuk hint
      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.HINT }, -- Tampilkan semua level, termasuk hint
          prefix = function(diag)
            return diag.severity == vim.diagnostic.severity.ERROR and "● " or
                   diag.severity == vim.diagnostic.severity.WARN and "⚠ " or
                   diag.severity == vim.diagnostic.severity.HINT and "✓ " or
                   "ℹ " -- Hint ditandai dengan ✓ hijau
          end,
          spacing = 4,
        },
        signs = true,
        update_in_insert = true, -- Perbarui diagnostik saat mengetik
        severity_sort = true,
      })

      -- Definisikan highlight untuk tanda dengan background transparan
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#00ff00", bg = "NONE" }) -- Hijau untuk hint
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff0000", bg = "NONE" }) -- Merah untuk error
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00", bg = "NONE" }) -- Kuning untuk warning
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00aaff", bg = "NONE" }) -- Biru untuk info

      -- Keymaps untuk LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local buf_opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end, vim.tbl_extend("force", buf_opts, { desc = "Goto Definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
        end,
      })

      -- Aktifkan diagnostik secara eksplisit untuk buffer saat ini
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("EnableDiagnostics", {}),
        callback = function(ev)
          vim.diagnostic.enable(true, { bufnr = ev.buf })
        end,
      })
    end,
  },
  -- dotenv.nvim
  {
    "ellisonleao/dotenv.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load on same events as lspconfig
    config = function()
      require("dotenv").setup({
        enable_on_load = true, -- Automatically load .env file when opening a buffer
        verbose = false, -- Disable notifications for .env file loading
        file_name = ".env", -- Use default .env file name
      })
    end,
  },
}
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        php = { "phpcs" },
        prisma = { "prisma-lint" },
      }

      -- Konfigurasi linter dengan logging untuk debug
      lint.linters.eslint_d = {
        cmd = "eslint_d",
        args = { "--format", "json", "--stdin", "--stdin-filename", function()
          return vim.api.nvim_buf_get_name(0)
        end },
        stdin = true,
        stream = "stderr",
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local decoded = vim.json.decode(output)
          if not decoded or not decoded[1] then
            vim.notify("Failed to parse eslint_d output: " .. output, vim.log.levels.ERROR)
            return {}
          end
          return decoded
        end,
      }

      lint.linters.phpcs = {
        cmd = "phpcs",
        args = { "--standard=PSR12", "-q", "--report=json", "--stdin-path", function()
          return vim.api.nvim_buf_get_name(0)
        end },
        stdin = true,
        ignore_exitcode = true,
        parser = function(output, bufnr)
          if output == "" then
            return {}
          end
          local decoded = vim.json.decode(output, { luanil = { object = true, array = true } })
          if not decoded then
            vim.notify("Failed to parse phpcs output: " .. output, vim.log.levels.ERROR)
            return {}
          end
          local diagnostics = {}
          for _, file in ipairs(decoded.files or {}) do
            for _, message in ipairs(file.messages or {}) do
              table.insert(diagnostics, {
                lnum = message.line - 1,
                col = message.column - 1,
                message = message.message,
                severity = message.type == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                source = "phpcs",
              })
            end
          end
          return diagnostics
        end,
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })

      -- Tambahkan logging untuk debug
      vim.api.nvim_create_autocmd("User", {
        pattern = "LintingStarted",
        callback = function()
          print("Linting started for buffer: " .. vim.api.nvim_get_current_buf())
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "LintingFinished",
        callback = function()
          print("Linting finished for buffer: " .. vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },
}
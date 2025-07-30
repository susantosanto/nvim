-- ===================================================================
-- 🚀 TOGGLETERM.NVIM: Multi Terminal Split Bawah + Keymaps
-- ===================================================================

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")

    -- Setup utama
    toggleterm.setup({
      size = 12,
      open_mapping = [[<c-\>]],      -- Default toggle (bisa di override)
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell, -- powershell.exe dari opt
    })

    -- Shortcut: Terminal class
    local Terminal = require("toggleterm.terminal").Terminal

    -- ===================================================================
    -- 🔧 Banyak Terminal (dengan count: 1, 2, 3)
    -- ===================================================================

    -- Fungsi buat terminal dengan count
    local function get_terminal(count)
      return Terminal:new({
        cmd = "powershell.exe",
        hidden = true,
        direction = "horizontal",
        count = count, -- penting: setiap terminal punya ID unik
        on_open = function()
          vim.cmd("startinsert")
        end,
        on_close = function()
          vim.notify("Terminal " .. count .. " closed", "info", { title = "ToggleTerm" })
        end,
      })
    end

    -- Terminal 1, 2, 3
    local term1 = get_terminal(1)
    local term2 = get_terminal(2)
    local term3 = get_terminal(3)

    -- ===================================================================
    -- ⌨️ Keymaps (Semua dalam satu blok)
    -- ===================================================================

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true, desc = desc })
    end

    -- Toggle terminal dengan count
    map("n", "<leader>t1", function()
      term1:toggle()
    end, "Toggle Terminal 1")

    map("n", "<leader>t2", function()
      term2:toggle()
    end, "Toggle Terminal 2")

    map("n", "<leader>t3", function()
      term3:toggle()
    end, "Toggle Terminal 3")

       -- ✅ FIX: Kill terminal dengan mengirim `exit`
    -- Karena kita tidak bisa deteksi aktif, kita kirim ke semua atau ke satu
    map("n", "<leader>tk", function()
      -- Kirim exit ke semua terminal (aman, yang tidak buka akan abaikan)
      for _, term in ipairs({ term1, term2, term3 }) do
        if term:is_open() then
          term:send("exit\r")
          vim.defer_fn(function()
            term:close()
          end, 300)
        end
      end
    end, "Kill: All active terminals")

    -- Kirim baris ke terminal
    map("n", "<leader>tl", function()
      vim.cmd("ToggleTermSendCurrentLine")
    end, "Send current line to terminal")

    map("v", "<leader>tl", "<esc><cmd>ToggleTermSendVisualSelection<cr>", "Send visual selection")

    -- Keluar dari terminal mode
    map("t", "<esc>", [[<C-\><C-n>]], "Exit terminal to Normal mode")
    map("t", "jk", [[<C-\><C-n>]], "Exit terminal with jk")
    map("t", "<C-w>", [[<C-\><C-n><C-w>]], "Window navigation")

    -- Optional: Status di command line
    -- vim.opt.statusline = "%!v:lua.require'toggleterm'.statusline()"
  end,
}
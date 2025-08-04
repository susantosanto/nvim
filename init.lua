if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")
require('telescope').setup {
  defaults = {
    mappings = {
      i = { -- Mode insert
        ["<C-s>"] = "select_horizontal", -- Buka file di split horizontal
        ["<C-v>"] = "select_vertical",   -- Buka file di split vertikal
      },
      n = { -- Mode normal
        ["s"] = "select_horizontal",     -- Buka file di split horizontal
        ["v"] = "select_vertical",       -- Buka file di split vertikal
      },
    },
  },
}

vim.opt.relativenumber = false -- Nonaktifkan relative number

-- Keybindings untuk Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true }) -- Cari file
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true }) -- Cari teks
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true }) -- Cari buffer

-- Keybinding untuk menutup buffer dan split
vim.keymap.set("n", "<leader>wc", function()
    vim.cmd("bd") -- Tutup buffer
    if vim.fn.winnr("$") > 1 then -- Jika ada lebih dari satu window
        vim.cmd("q") -- Tutup window/split
    end
end, { noremap = true, silent = true, desc = "Close buffer and split" })

-- Atur shell ke PowerShell
vim.opt.shell = "powershell.exe"
vim.opt.shellcmdflag = "-c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
vim.opt.shellpipe = ">"
vim.opt.shellredir = ">"

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.jsx"},
  command = "set filetype=javascriptreact",
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.tsx"},
  command = "set filetype=typescriptreact",
})


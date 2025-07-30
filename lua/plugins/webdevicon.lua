return {
  "nvim-tree/nvim-web-devicons",
  lazy = false, -- Pastikan tidak lazy-loaded agar ikon langsung tersedia
  config = function()
    require("nvim-web-devicons").setup({
      -- Konfigurasi global untuk ikon
      override = {
        -- Kustomisasi ikon untuk beberapa tipe file
        ["ts"] = {
          icon = "",
          color = "#3178C6", -- Biru TypeScript untuk kesan profesional
          name = "TypeScript",
        },
        ["js"] = {
          icon = "",
          color = "#F7DF1E", -- Kuning JavaScript, tetap elegan
          name = "JavaScript",
        },
        ["py"] = {
          icon = "",
          color = "#3572A5", -- Biru Python yang lembut
          name = "Python",
        },
        ["lua"] = {
          icon = "",
          color = "#00007C", -- Biru tua untuk Lua, cocok dengan Neovim
          name = "Lua",
        },
        ["md"] = {
          icon = "",
          color = "#83A598", -- Hijau muted untuk Markdown
          name = "Markdown",
        },
        ["json"] = {
          icon = "",
          color = "#CBBA6D", -- Emas muted untuk JSON
          name = "Json",
        },
        ["yaml"] = {
          icon = "",
          color = "#D08770", -- Oranye lembut untuk YAML
          name = "Yaml",
        },
        -- Folder kustom untuk proyek
        ["src"] = {
          icon = "",
          color = "#6B7280", -- Abu-abu modern untuk folder src
          name = "Src",
        },
        ["tests"] = {
          icon = "",
          color = "#9F7AEA", -- Ungu lembut untuk folder tests
          name = "Tests",
        },
      },
      -- Ikon default untuk file/folder yang tidak dikenali
      default = true,
      -- Override berdasarkan ekstensi file
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#4B5E40", -- Hijau tua untuk file log
          name = "Log",
        },
        ["conf"] = {
          icon = "",
          color = "#6B7280", -- Abu-abu netral untuk file config
          name = "Config",
        },
      },
      -- Override berdasarkan nama file
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#F1502F", -- Merah Git untuk kesan kuat
          name = "GitIgnore",
        },
        ["README.md"] = {
          icon = "",
          color = "#83A598", -- Hijau Markdown untuk README
          name = "Readme",
        },
        ["Dockerfile"] = {
          icon = "",
          color = "#0DB7ED", -- Biru Docker yang cerah namun elegan
          name = "Dockerfile",
        },
      },
      -- Warna global untuk ikon default
      color_icons = true,
      -- Pastikan ikon ditampilkan dengan benar di terminal
      strict = true,
    })

    -- Set highlight groups untuk warna ikon yang lebih elegan
    vim.api.nvim_set_hl(0, "NvimWebDeviconsDefault", { fg = "#A3BFFA" }) -- Biru muda untuk ikon default
    vim.api.nvim_set_hl(0, "NvimWebDeviconsFolder", { fg = "#6B7280", bold = true }) -- Abu-abu untuk folder
    vim.api.nvim_set_hl(0, "NvimWebDeviconsFile", { fg = "#E5E7EB" }) -- Abu-abu terang untuk file
  end,
}
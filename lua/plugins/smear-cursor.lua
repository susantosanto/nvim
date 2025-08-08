return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy", -- Memuat plugin setelah Neovim selesai dimuat
    cond = vim.g.neovide == nil, -- Nonaktifkan jika menggunakan Neovide
    opts = {
      cursor_color = "none", -- Mengikuti warna teks di posisi kursor
      smear_between_buffers = false, -- Matikan smear antar buffer untuk efek minimal
      smear_between_neighbor_lines = true, -- Animasi saat bergerak antar baris
      smear_insert_mode = true, -- Animasi di insert mode
      stiffness = 0.8, -- Kecepatan gerakan kepala kursor lebih cepat
      trailing_stiffness = 0.9, -- Kecepatan ekor kursor sangat cepat
      damping = 0.9, -- Pengurangan kecepatan tinggi untuk bayangan minimal
      trailing_exponent = 1.2, -- Distribusi bayangan sangat tipis
      distance_stop_animating = 0.02, -- Jarak berhenti animasi sangat kecil
      time_interval = 10, -- Framerate tinggi untuk animasi halus
      legacy_computing_symbols_support = false, -- Nonaktifkan simbol legacy
    },
    specs = {
      -- Nonaktifkan animasi kursor dari mini.animate (jika ada)
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
}
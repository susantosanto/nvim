return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    arg = "leetcode.nvim",
    lang = "javascript", -- Bahasa default diatur ke JavaScript
    cn = { -- Untuk LeetCode.cn
      enabled = false,
      translator = true,
      translate_problems = true,
    },
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    plugins = {
      non_standalone = false, -- Sesuaikan jika menggunakan dashboard seperti alpha.nvim
    },
    injector = { -- Injeksi kode untuk bahasa yang kamu pilih
      ["javascript"] = {
        imports = function()
          return { "const { assert } = require('chai');" }
        end,
        after = { "describe('Test', () => {", "  it('should work', () => {", "    assert.equal(solution(), expected);", "  });", "});" },
      },
      ["typescript"] = {
        imports = function()
          return { "import { assert } from 'chai';" }
        end,
        after = { "describe('Test', () => {", "  it('should work', () => {", "    assert.equal(solution(), expected);", "  });", "});" },
      },
      ["php"] = {
        imports = function()
          return { "<?php", "use PHPUnit\\Framework\\TestCase;" }
        end,
        after = { "class SolutionTest extends TestCase {", "  public function testExample() {", "    $this->assertEquals(expected, solution());", "  }", "}" },
      },
    },
    console = {
      dir = "row", -- Orientasi konsol
      size = { width = "90%", height = "75%" },
    },
    description = {
      position = "left", -- Lokasi deskripsi soal
      width = "40%",
    },
  },
}
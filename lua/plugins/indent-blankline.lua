return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "", -- Solid vertical line for continuous indent guides
      },
      whitespace = {
        remove_blankline_trail = false, -- Prevent gaps by keeping trailing whitespace
      },
    },
  }
}

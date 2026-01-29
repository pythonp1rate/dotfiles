return {
  "folke/tokyonight.nvim",
  priority = 1000,
  opts = {
    style = "night", -- change to "storm" | "moon" | "day" if you prefer
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}

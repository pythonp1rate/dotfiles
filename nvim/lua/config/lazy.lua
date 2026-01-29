local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Load LazyVim core first (this gives you the logo, dashboard, defaults, etc.)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- (Optional) add LazyVim extras here if you want later
    -- { import = "lazyvim.plugins.extras.coding.luasnip" },

    -- Your plugins folder
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = false },
})

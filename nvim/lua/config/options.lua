-- Keep this minimal—LazyVim already sets solid defaults.
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "split"
opt.completeopt = { "menu", "menuone", "noselect" }

opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 500

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"

opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "indent"

opt.shortmess:append("I")
opt.conceallevel = 0

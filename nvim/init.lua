-- Leaders MUST be set before lazy starts
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Optional providers off
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Python host (your path from earlier)
vim.g.python3_host_prog = "/home/mads/.local/bin/pynvim-python"

-- Boot lazy + LazyVim + your stuff
require("config.lazy")

-- Your custom options & keymaps (run after LazyVim)
require("config.options")
require("config.keymaps")

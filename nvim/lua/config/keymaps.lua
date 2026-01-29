-- Your custom keymaps (non-destructive; plays nice with LazyVim)
local map = vim.keymap.set

-- WINDOW MANAGEMENT
map("n", "<leader>ww", function() end, { desc = "Windows Picker" })
map("n", "<leader>wd", "<cmd>close<CR>", { desc = "Delete Window" })
map("n", "<leader>wm", function()
    pcall(require, "zen-mode")
    if package.loaded["zen-mode"] then require("zen-mode").toggle() end
end, { desc = "Zoom Window" })

map("n", "<C-H>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-J>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-K>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-L>", "<C-w>l", { desc = "Window Right" })

map("n", "<M-h>", "<C-w><", { desc = "Resize Left" })
map("n", "<M-l>", "<C-w>>", { desc = "Resize Right" })
map("n", "<M-j>", "<C-w>-", { desc = "Resize Down" })
map("n", "<M-k>", "<C-w>+", { desc = "Resize Up" })

map("n", "<leader>wv", "<C-w>v", { desc = "Vertical Split" })
map("n", "<leader>wh", "<C-w>s", { desc = "Horizontal Split" })
map("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close Split" })

-- FILES & TELESCOPE
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Doc Symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Grep Word" })
map("v", "<leader>fw", "y<cmd>Telescope grep_string<CR>", { desc = "Grep Selection" })

-- BUFFERS
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })



-- TERMINAL
map("n", "<leader>tf", "<cmd>ToggleTerm size=15 direction=horizontal<CR>", { desc = "Term Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<CR>", { desc = "Term Vertical" })

-- BIG FLOAT (focus mode)
map("n", "<leader>th", "<cmd>ToggleTerm direction=float<CR>", { desc = "Term Float (Big)" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])




-- DBUI
map("n", "<leader>dd", "<cmd>DBUIToggle<CR>", { desc = "Toggle DBUI" })
map("n", "<leader>da", "<cmd>DBUIAddConnection<CR>", { desc = "Add Connection" })
map("n", "<leader>dr", "<cmd>DBUIRenameConnection<CR>", { desc = "Rename Connection" })
map("n", "<leader>dx", "<cmd>DBUIDeleteConnection<CR>", { desc = "Delete Connection" })
map("n", "<leader>ds", "<cmd>DBUISaveQuery<CR>", { desc = "Save Query" })
map("n", "<leader>de", "<cmd>DBUIExecuteQuery<CR>", { desc = "Execute Query" })
map("n", "<leader>db", "<cmd>DBUIExecuteBuffer<CR>", { desc = "Run SQL Buffer" })
map("v", "<leader>ds", "<cmd>DBUIExecuteSelection<CR>", { desc = "Run Selection" })
map("n", "<leader>dq", "<cmd>DB<CR>", { desc = "DB Command" })

-- PYTHON RUNNER
map("n", "<leader>rr", function()
    vim.cmd("w")
    vim.cmd("!python3 %")
end, { desc = "Run Current Python File" })

-- SNACKS EXPLORER
map("n", "<leader>e", function()
    local ok, snacks = pcall(require, "snacks")
    if ok then snacks.explorer() end
end, { desc = "Open Snacks Explorer" })
map("n", "<leader>E", function()
    local ok, snacks = pcall(require, "snacks")
    if ok then snacks.explorer({ reveal = true }) end
end, { desc = "Reveal Current File (Snacks)" })
map("n", "<leader>zh", function()
    if vim.bo.filetype == "snacks_explorer" then
        vim.cmd("normal! zh")
    else
        print("Snacks Explorer is not open")
    end
end, { desc = "Toggle Hidden Files (Snacks)" })

-- LSP BASICS
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })

-- DIAGNOSTICS
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>xe", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Diagnostics List" })

-- UTIL
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit All" })
map("n", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from Clipboard" })
map("n", "Y", "y$", { desc = "Yank to EOL" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear Highlights" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "Q", "<nop>")

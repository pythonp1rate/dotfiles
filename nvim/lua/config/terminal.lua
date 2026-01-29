local M = {}

M.setup = function()
    require("toggleterm").setup({
        size = 15,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 1,
        start_in_insert = true,
        persist_size = false, -- IMPORTANT: prevents old layout reuse
        direction = "horizontal", -- REAL split
        shell = "/sbin/fish", -- explicit path, no guessing
        close_on_exit = true,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local py_repl = Terminal:new({
        cmd = "/sbin/fish -c python",
        hidden = true,
        direction = "horizontal",
        close_on_exit = true,
    })

    function _PYTHON_REPL_TOGGLE()
        py_repl:toggle()
    end
end

return M

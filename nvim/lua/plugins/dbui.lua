-- File: ~/.config/nvim/lua/plugins/dbui.lua

return {
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 1
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            vim.g.db_ui_execute_on_save = 0

            vim.g.dbs = {
                { name = "electronics_db", url = "postgresql://postgres:postgres@localhost:5435/electronics_db" },
                { name = "project_db",     url = "postgresql://postgres:postgres@localhost:5434/project_db" },
            }

            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui_queries"
        end,
    },

    -- Optional: Add completion support for SQL files
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = {
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
            },
        },
        opts = function(_, opts)
            -- FIX: ensure opts.sources exists
            opts.sources = opts.sources or {}

            -- Add dadbod completion source safely
            table.insert(opts.sources, { name = "vim-dadbod-completion" })

            return opts
        end,
    },
}


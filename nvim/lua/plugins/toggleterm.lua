return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("config.terminal").setup()
    end,
}

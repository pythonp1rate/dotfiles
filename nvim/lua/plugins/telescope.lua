return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = { width = 0.95, height = 0.85, preview_width = 0.55 },
          vertical = { width = 0.90, height = 0.95, preview_height = 0.50 },
        },
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        selection_caret = " ",
        path_display = { "truncate" },
      },
      pickers = {
        find_files = { theme = "dropdown", previewer = false },
        buffers = { theme = "dropdown", previewer = false },
        help_tags = { theme = "ivy" },
        oldfiles = { theme = "dropdown" },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })

    -- Load FZF for max speed
    pcall(telescope.load_extension, "fzf")
  end,
}

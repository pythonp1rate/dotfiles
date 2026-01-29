return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = {
      python = { "ruff_fix", "ruff_format", "black" },
      sql = { "pgformatter" },
    }
    opts.formatters = {
      pgformatter = { command = "pg_format" },
    }
    return opts
  end,
}

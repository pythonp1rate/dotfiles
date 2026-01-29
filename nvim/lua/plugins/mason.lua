return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "pyright", "ruff", "black", "debugpy",
      "sqls", "pgformatter",
      "gopls", "goimports", "delve",
    },
  },
}

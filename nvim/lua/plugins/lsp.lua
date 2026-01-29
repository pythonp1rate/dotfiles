return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {},
      sqls = {
        settings = {
          sqls = {
            connections = {
              {
                driver = "postgresql",
                dataSourceName =
                  "host=localhost user=postgres password=postgres dbname=postgres sslmode=disable",
              },
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            analyses = { unusedparams = true },
          },
        },
      },
    },
  },
}

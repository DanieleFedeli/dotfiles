-- File: lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        vtsls = {
          settings = {
            typescript = {
              maxTsServerMemory = 1500,
            },
          },
        },
      },
    },
  },
}

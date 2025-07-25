return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
      vtsls = {
        enabled = false,
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}

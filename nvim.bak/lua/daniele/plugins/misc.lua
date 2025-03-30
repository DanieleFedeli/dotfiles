return {
  { "stevearc/dressing.nvim" },
  {
    'williamboman/mason.nvim',
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts =
    {
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "lua_ls",
        "eslint",
        "graphql",
        "biome"
      },
      automatic_installation = true
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}

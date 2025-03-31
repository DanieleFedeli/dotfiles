---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "giuxtaposition/blink-cmp-copilot" },
    },
    event = "InsertEnter",
    enabled = function()
      return not vim.tbl_contains({ "copilot" }, vim.bo.filetype)
    end,
    opts = {
      sources = {
        default = { "lazydev", "copilot", "lsp", "path", "buffer" },
        providers = {
          copilot = {
            name = "Copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}

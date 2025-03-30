---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "giuxtaposition/blink-cmp-copilot" },
    },
    event = "InsertEnter",
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

return {
  { "onsails/lspkind.nvim",        event = { "BufReadPre", "BufNewFile" } },
  { "L3MON4D3/LuaSnip",            event = { "BufReadPre", "BufNewFile" } },
  { "nvim-lua/plenary.nvim",       event = { "BufReadPre", "BufNewFile" } },
  { "windwp/nvim-ts-autotag",      dependencies = "nvim-treesitter",             event = "InsertEnter" },
  { "almo7aya/openingh.nvim",      cmd = { "OpenInGHFile", "OpenInGHFileLines" } },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "tpope/vim-surround",          event = { "BufReadPre", "BufNewFile" } },
}

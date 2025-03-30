---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  opts = {
    at_edge = "wrap",
    ignored_filetypes = {},
    ignored_buftypes = {},
    default_amount = 3,
    move_cursor_same_row = false,
    cursor_follows_swapped_bufs = false,
    resize_mode = {
      quit_key = "<ESC>",
      resize_keys = { "h", "j", "k", "l" },
      silent = false,
    },
    -- Add user vars for WezTerm integration
    multiplexer_integration = "wezterm",
  },
}

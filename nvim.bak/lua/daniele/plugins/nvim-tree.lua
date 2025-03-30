-- indent char from settings
local settings = require("daniele.settings")

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr, opts)
  vim.keymap.set("n", "<leader>e", api.tree.toggle)
end

-- custom setup
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    live_filter = {
      always_show_folders = false,
    },
    view = {
      width = 40,
      side = 'right',
    },
    renderer = {
      hidden_display = "all",
      root_folder_label = ".",
      indent_markers = {
        enable = false, -- folder level guide
        icons = {
          corner = "└",
          edge = settings.indentChar,
          item = settings.indentChar,
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        glyphs = {
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
          },
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    actions = {
      open_file = {
        resize_window = true,
        window_picker = {
          enable = false,
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    filters = {
      dotfiles = true,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    on_attach = on_attach,
  },
}

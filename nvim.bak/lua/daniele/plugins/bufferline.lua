--- @module 'bufferline'
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons", },
  opts = {
    options = {
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      numbers = "ordinal",        -- add tabs ordinal numbers
      color_icons = "gruvbox",
      tab_size = 18,              -- default: 18
      close_icon = "",
      show_buffer_icons = true,
      enforce_regular_tabs = true,
      show_duplicate_prefix = true, -- show base path if tabs have the same name
      separator_style = "thick",    -- slant|slope|thick|thin|{"|", "|"}
      diagnostics = "nvim_lsp",     -- nvim lsp diagnostics integration in tabs or false
      indicator = {
        -- icon = "", -- ▎
        style = "icon", -- icon|underline|none
      },
      -- offsets = {
      --   -- avoid to show bufferline on top nvim-tree
      --   {
      --     filetype = "NvimTree",
      --     text = "File Explorer", -- title on top
      --     highlight = "Directory",
      --     separator = true,       -- true is the default, or set custom
      --   },
      --   -- avoid to show bufferline on top saga outline symbols
      --   {
      --     filetype = "sagaoutline",
      --     text = "Symbols", -- title on top
      --     highlight = "Directory",
      --     separator = true, -- true is the default, or set custom
      --   },
      -- },
      diagnostics_indicator = function(count, level) -- diagnostics format
        --- @diagnostic disable-next-line: undefined-field
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      -- exclude some buffer and file types
      custom_filter = function(buf_number)
        local buftype = vim.api.nvim_buf_get_option(buf_number, "buftype")
        local filetype = vim.api.nvim_buf_get_option(buf_number, "filetype")

        -- exclude list
        local excluded_filetypes = {
          ["terminal"] = true,
          ["NvimTree"] = true,
          ["sagaoutline"] = true,
          ["sagafinder"] = true,
          ["starter"] = true,
        }

        local excluded_buftypes = {
          ["nofile"] = true,
          ["terminal"] = true,
        }

        return not excluded_buftypes[buftype] and not excluded_filetypes[filetype]
      end,
    },
  }
}

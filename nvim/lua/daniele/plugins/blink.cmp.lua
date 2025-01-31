return {
  { "Bilal2453/luvit-meta" },
  { "justinsgithub/wezterm-types" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      enabled = true,
      library = {
        "luvit-meta/library",
        "wezterm-types/types",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        --[[
          vim.fn.expand "$HOME/workspace/neovim/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          vim.fn.expand "$VIMRUNTIME/lua/vim",
          "${3rd}/luv/library",
        ]]
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "giuxtaposition/blink-cmp-copilot" }
    },
    event = "InsertEnter",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              }
            }
          }
        }
      },
      sources = {
        default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "Copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 90,
          },
        },
      },
      keymap = {
        -- preset = 'enter',
        ["<C-y>"] = { "accept" }
      }
    },
  }
}

return {
  { "Bilal2453/luvit-meta" },
  { "justinsgithub/wezterm-types", },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      { "justinsgithub/wezterm-types", },
    },
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "luvit-meta/library",
        {
          path = vim.fn.stdpath("data") .. "/lazy/wezterm-types/types",
          mods = { "wezterm" }
        },
        { 'lazy.nvim',                 words = { 'lazy', 'LazySpec', 'LazyKeys', 'LazyKeysSpec' } },
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
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
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local lspkind = require("lspkind")
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              }
            }
          }
        }
      },
      sources = {
        default = { "lazydev", "copilot", "lsp", "path", "buffer" },
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
            score_offset = 100,
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

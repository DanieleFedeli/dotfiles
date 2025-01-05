return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'saghen/blink.cmp' },
      { "antosha417/nvim-lsp-file-operations" },
    },
    opts = {
      inline_hints = {
        enabled = true,
      },
      servers = {
        tsserver = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
          end
        }
      }
    },
    config = function()
      local lsp = require("lspconfig")
      local blink = require("blink.cmp")

      local keymap = vim.keymap

      local opts = { noremap = true, silent = true }

      local on_attach = function(_client, bufnr)
        opts.buffer = bufnr

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostic"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Prev diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show type"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Format code"
        keymap.set("n", "<leader>F", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end

      local capabilities = blink.get_lsp_capabilities()

      lsp['html'].setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      lsp['ts_ls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = true,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      })

      lsp['bashls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = true,
      })

      lsp['graphql'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = true,
      })

      lsp['biome'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "npx", "biome", "lsp-proxy" },
        settings = {
          format = { enable = true, command = "biome-langserver", args = {} }
        },
      })

      lsp['cssls'].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })

      lsp['rust_analyzer'].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })

      lsp['lua_ls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              }
            }
          }
        }
      })
    end
  }
}

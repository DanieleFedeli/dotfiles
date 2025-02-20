return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = 'main',
    opts = {
      window = {
        layout = 'float',
      },
      model = 'claude-3.5-sonnet',
      mappings = {
        reset = {
          normal = '<C-R>',
          instert = '<C-R>'
        }
      },
      prompts = {
        Optimize = {
          mapping = '<leader>co',
        },
        Docs = {
          mapping = '<leader>cdoc',
          prompt = '> /COPILOT_GENERATE\n\nAdd documentation to the selected code. Use simple words.',
        },
        Fix = {
          mapping = '<leader>cf',
        },
        Explain = {
          mapping = '<leader>ce',
        },
        Commit = {
          prompt =
          '> #git:staged\n\nWrite a Git commit message with:\n\n1. **Title**: Imperative, max 50 chars, only the first char is uppercase.\n\n2. (Blank line)\n\n3. **Subtitle** (optional): Imperative, max 72 chars, only if it makes the commit message clearer.\n\n**Rules:**\n- Blank line between title and subtitle.\n- No body; only title and optional subtitle.\n- Be clear and concise.\n\nWrap the whole message in a code block with language gitcommit.',
          mapping = '<leader>ccm',
        },
      }
    },
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false }
          })
        end,
      },
      { "nvim-lua/plenary.nvim" },
    },
  },
}

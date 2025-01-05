return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ---@module 'fzf-lua'
  ---@type 'fzf-lua.Config'
  opts = {
    git = {
      file_icons = true
    },
    win_options = {
      default = 'bat',
      vertical = 'down:40%'
    },
    keymap = {
      fzf = {
        ['ctrl-q'] = 'select-all+accept'
      }
    },
    oldfiles = {
      include_current_session = true,
    },
    grep = {
      rg_glob = true,
      glob_flag = '--iglob',
      glob_separator = '%s%-%-'
    }
  },
  config = function(_, opts)
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    local keymap = vim.keymap

    fzf.setup(opts)

    keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })

    keymap.set("n", '<leader>sf', fzf.files, { desc = "[S]earch [F]iles" })
    keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
    keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    keymap.set('n', '<leader>sw', fzf.grep_cWORD, { desc = '[S]earch [W]ord' })
    keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
    keymap.set('n', '<leader>sG', fzf.live_grep_resume, { desc = '[S]earch by [G]rep resume' })
    keymap.set('n', '<leader>.', function()
      fzf.files({
        cwd       = vim.fn.expand('%:p:h'),
        hidden    = true,
        no_ignore = true,
      })
    end, { desc = 'Search siblings' })

    keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })


    keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostic' })
    keymap.set('n', '<leader>sD', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostic in workspace' })

    keymap.set("n", '<leader>sb', fzf.git_blame, { desc = "[S]earch [B]lame" })
    keymap.set("n", '<leader>sC', fzf.git_commits, { desc = "[S]earch [C]ommit" })
    keymap.set("n", '<leader>sc', fzf.git_commits, { desc = "[S]earch [C]ommit by buffer" })

    keymap.set("n", '<leader>ca', fzf.lsp_code_actions, { desc = "[C]ode [A]ctions" })
    keymap.set("n", 'gr', fzf.lsp_references, { desc = "[S]earch [R]eferences" })
    keymap.set("n", 'gd', fzf.lsp_definitions, { desc = "[S]earch [D]efinitions" })
    keymap.set("n", 'gD', fzf.lsp_declarations, { desc = "[S]earch [D]eclarations" })
  end
}

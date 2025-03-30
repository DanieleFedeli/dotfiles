return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts =
  {
    preview_config = {
      border = "rounded",
      style = "minimal",
    },
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next hunk' })

      map('n', '[h', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'Prev hunk' })

      -- Actions
      local opts = {};

      opts.desc = 'Stage hunk'
      map('n', '<leader>hs', gs.stage_hunk, opts)

      opts.desc = 'Reset hunk'
      map('n', '<leader>hr', gs.reset_hunk, opts)

      opts.desc = 'Undo stage hunk'
      map('n', '<leader>hu', gs.undo_stage_hunk, opts)

      opts.desc = 'Stage hunk visual mode'
      map('v', '<leader>hs',
        function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)

      opts.desc = 'Reset hunk visual mode'
      map('v', '<leader>hr',
        function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)

      opts.desc = 'Preview hunk'
      map('n', '<leader>hp', gs.preview_hunk, opts)

      opts.desc = 'Stage buffer'
      map('n', '<leader>hS', gs.stage_buffer, opts)

      opts.desc = 'Reset buffer'
      map('n', '<leader>hR', gs.reset_buffer, opts)

      opts.desc = 'Git blame'
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, opts)
      map('n', '<leader>tb', gs.toggle_current_line_blame, opts)

      opts.desc = 'Git diff'
      map('n', '<leader>hd', gs.diffthis, opts)
      map('n', '<leader>hD', function() gs.diffthis('~') end, opts)
      map('n', '<leader>td', gs.toggle_deleted, opts)

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  },
}

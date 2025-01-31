local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<Up>", "<Nop>", opts)
keymap.set("n", "<Down>", "<Nop>", opts)
keymap.set("n", "<Left>", "<Nop", opts)
keymap.set("n", "<Right>", "<Nop>", opts)

-- Movement
keymap.set({ "n", "v" }, "H", "^", opts)
keymap.set({ "n", "v" }, "L", "$", opts)

-- -- Select all
-- keymap.set('n', "<C-a>", "gg<S-v>G")

-- Use sytstem clipboard
keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

-- Tabs navigation
keymap.set('n', ']t', '<CMD>BufferLineCycleNext<CR>')
keymap.set('n', '[t', '<CMD>BufferLineCyclePrev<CR>')

-- Map <Esc> in terminal mode to exit to normal mode
keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Remap window navigation
keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

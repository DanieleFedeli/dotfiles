-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Up>", "<Nop>", opts)
vim.keymap.set("n", "<Down>", "<Nop>", opts)
vim.keymap.set("n", "<Left>", "<Nop>", opts)
vim.keymap.set("n", "<Right>", "<Nop>", opts)

-- Use system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

-- Move between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

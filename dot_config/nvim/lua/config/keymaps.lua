-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally

-- movement
vim.cmd("nmap j gj") -- avoid line wrap
vim.cmd("nmap k gk") -- avoid line wrap

keymap.set({ "n", "v" }, "J", "5jzz", { desc = "Move down 5 row at a time and center screen " })
keymap.set({ "n", "v" }, "K", "5kzz", { desc = "Move up 5 row at a time and center screen " })

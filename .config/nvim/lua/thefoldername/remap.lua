local map = vim.api.nvim_set_keymap
local maps_ = vim.keymap.set --used to map multiple modes at once
local opts = { noremap = true, silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

--write and exit remaps

map("n", "<leader>e", "<Cmd>Ex<CR>", opts)
map("n", "<leader>s", "<Cmd>w!<CR>", opts)

--exit out of insert and visual modes

map("i", "<A-i>", "<ESC>", opts)
map("i", "<A-a>", "<ESC>", opts)
map("v", "<v>", "<ESC>", opts)

--window navigation remaps

maps_({"i", "n", "v"}, "<C-Up>", "<Cmd>wincmd k<CR>", opts)
maps_({"i", "n", "v"}, "<C-Down>", "<Cmd>wincmd j<CR>", opts)
maps_({"i", "n", "v"}, "<C-Left>", "<Cmd>wincmd h<CR>", opts)
maps_({"i", "n", "v"}, "<C-Right>", "<Cmd>wincmd l<CR>", opts)

--tab shifting selected text right and left remaps

map("v", ",", "<gv", opts) --left
map("v", ".", ">gv", opts) --right


--[BEGIN] below worked for me, might not work for you, I recommend checking out https://www.youtube.com/watch?v=435-amtVYJ8&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=5 ~@11:04

--moving selected text up and down file

map("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)                                                                                            
map("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)                                                                                            
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)                                                                                             
map("v", "<A-k>", ":m '<-2<CR>==gv", opts)

--[END]


--When pasting yanked text over selection and removing said selection, not overriding the register storing the yank with the now deleted text 

map("v", "p", '"_dP', opts)

--Should deselect text once highlighted through search

map("n", "<Esc>", "<Cmd>noh<CR>", opts)

--map control for insert, normal, visual modes and regular movement for insert to hjkl in insert mode

maps_({"i", "n", "v"}, "<C-h>", "<C-left>", opts)
maps_({"i", "n", "v"}, "<C-j>", "<C-down>", opts)
maps_({"i", "n", "v"}, "<C-k>", "<C-up>", opts)
maps_({"i", "n", "v"}, "<C-l>", "<C-right>", opts)

map("i", "<A-h>", "<left>", opts)
map("i", "<A-j>", "<down>", opts)
map("i", "<A-k>", "<up>", opts)
map("i", "<A-l>", "<right>", opts)




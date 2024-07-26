local map = vim.api.nvim_set_keymap
local maps_ = vim.keymap.set --used to map multiple modes at once
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

--write and exit remaps

map("n", "<leader>e", "<Cmd>Ex<CR>", opts)
map("n", "<leader>s", "<Cmd>w!<CR>", opts)

--exit out of insert and visual modes

map("i", "<A-i>", "<ESC>", opts)
map("i", "<A-a>", "<ESC>", opts)
map("x", "v", "<ESC>", opts)

--map block select v mode

map("n", "<C-S-v>", "<C-v>", opts)

--map i to enter from right of cursor and a to enter from left of cursor

map("n", "i", "a", opts)
map("n", "a", "i", opts)

maps_({"n", "x"}, "<S-i>", "<S-a>", opts)
maps_({"n", "x"}, "<S-a>", "<S-i>", opts)

--window navigation remaps

maps_({"i", "n", "v"}, "<C-Up>", "<Cmd>wincmd k<CR>", opts)
maps_({"i", "n", "v"}, "<C-Down>", "<Cmd>wincmd j<CR>", opts)
maps_({"i", "n", "v"}, "<C-Left>", "<Cmd>wincmd h<CR>", opts)
maps_({"i", "n", "v"}, "<C-Right>", "<Cmd>wincmd l<CR>", opts)

--tab shifting selected text right and left remaps

map("v", "<A-,>", "<gv", opts) --left
map("v", "<A-.>", ">gv", opts) --right

maps_({"i", "n"}, "<A-,>", "<Cmd><<CR>", opts)
maps_({"i", "n"}, "<A-.>", "<Cmd>><CR>", opts)

--[BEGIN] below worked for me, might not work for you, I recommend checking out https://www.youtube.com/watch?v=435-amtVYJ8&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=5 ~@11:04

--moving selected text up and down file

map("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
map("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>==gv", opts)

--[END]

--map quit

--vim.keymap.del("n", "<Cmd>lua vim.diagnostic.setloclist()<CR>", {buffer = true})

maps_({"n", "v"}, "<leader>q", "<Cmd>q<CR>", opts)

--map undo and redo

maps_({"i", "n", "v"}, "<C-z>", "<Cmd>u<CR>", opts)
maps_({"i", "n", "v"}, "<C-S-z>", "<C-r>", opts)

--Copy to system Clipboard

maps_({"n", "v"}, "<C-c>", '"+y', opts)

--When pasting yanked text over selection and removing said selection, not overriding the register storing the yank with the now deleted text 

map("v", "p", '"_dP', opts)

--Should deselect text once highlighted through search

map("n", "<Esc>", "<Cmd>noh<CR>", opts)

--map go to end/begining of a line

maps_({"i", "n", "v"}, "<C-,>", "<Home>", opts)
maps_({"i", "n", "v"}, "<C-.>", "<End>", opts)

--map ),} to go up and (,{ to go down

maps_({"n", "v"}, ")", "(", opts)
maps_({"n", "v"}, "(", ")", opts)
maps_({"n", "v"}, "}", "{", opts)
maps_({"n", "v"}, "{", "}", opts)

map("i", "<A-0>", "<Cmd>normal )<CR>", opts)
map("i", "<A-9>", "<Cmd>normal (<CR>", opts)
map("i", "<A-]>", "<Cmd>normal }<CR>", opts)
map("i", "<A-[>", "<Cmd>normal {<CR>", opts)

--map control for insert, normal, visual modes and regular movement for insert to hjkl in insert mode

local readline = require "readline"

maps_({"i", "n", "v"}, "<C-h>", readline.backward_word, opts)
maps_({"i", "n", "v"}, "<C-j>", "<Cmd>normal {<CR>", opts)
maps_({"i", "n", "v"}, "<C-k>", "<Cmd>normal }<CR>", opts)
maps_({"i", "n", "v"}, "<C-l>", readline.forward_word, opts)

map("i", "<A-h>", "<left>", opts)
map("i", "<A-j>", "<down>", opts)
map("i", "<A-k>", "<up>", opts)
map("i", "<A-l>", "<right>", opts)

local options = {

clipboard = "unnamedplus",
completeopt = { "menuone", "noselect" },
fileencoding = "utf-8",
hlsearch = true,
pumheight = 10,
showmode = false,
showtabline = 2,
smartindent = true,
swapfile = false,
termguicolors = true,
background = "light",
undofile = true,
updatetime = 300,
expandtab = true,
tabstop = 4,
shiftwidth = 0,
number = true,
relativenumber = false,
numberwidth = 1,
signcolumn = "yes",
wrap = false,
scrolloff = 8,
sidescrolloff = 8

}

vim.opt.shortmess:append "c"


for key, value in pairs(options) do
    vim.opt[key] = value
end

--vim.cmd([[colorscheme gruvbox]])

vim.cmd([[colorscheme moonfly]])

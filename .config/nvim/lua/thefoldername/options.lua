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
cursorline = true,
background = "light",
undofile = true,
updatetime = 300,
expandtab = true,
tabstop = 4,
shiftwidth = 0,
softtabstop = 4,
number = true,
relativenumber = false,
numberwidth = 1,
signcolumn = "yes",
wrap = false,
scrolloff = 8,
sidescrolloff = 8,
laststatus = 3
}


vim.opt.shortmess:append "c"
--vim.opt.fillchars:append "vert:|"
--vim.opt.fillchars:append "horiz:-"
--vim.o.fillchars = "vert:⎸,horiz:━"
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
vim.opt.fillchars:append "eob: "
vim.opt.whichwrap:append "h,l,<,>,[,]" --ToDo: Add new char for whichwrap which links to Insert: "<A-h> and <A-l>" movements

for key, value in pairs(options) do
    vim.opt[key] = value
end

--vim.cmd([[colorscheme gruvbox]])

vim.cmd([[colorscheme moonfly]])

vim.cmd("hi VertSplit gui=reverse guifg=#080808")

--Necessary for moonfly when vim.api.nvim_set_hl(0, "Normal", {bg = "none"}) is not commented

vim.cmd("hi clear SignColumn")

vim.cmd("hi clear WinSeparator")

vim.cmd("hi clear LineNr")

--Makes it so cursorline only highlights the buffer/window you are on.
vim.cmd([[
        
        augroup CursorLine
            au!
            au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
            au WinLeave * setlocal nocursorline
        augroup END

]])

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
--vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

vim.cmd("au! BufRead,BufNewFile *.vert,*.frag set filetype=glsl")

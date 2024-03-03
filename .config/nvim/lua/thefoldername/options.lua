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
sidescrolloff = 8,
}


vim.opt.shortmess:append "c"
vim.opt.fillchars:append "vert: "
vim.opt.fillchars:append "horiz: "
vim.opt.fillchars:append "eob: "
vim.opt.whichwrap:append "h,l,<,>,[,]" --ToDo: Add new char for whichwrap which links to Insert: "<A-h> and <A-l>" movements

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


for key, value in pairs(options) do
    vim.opt[key] = value
end

--vim.cmd([[colorscheme gruvbox]])

vim.cmd([[colorscheme moonfly]])
vim.cmd("highlight WinSeparator gui=reverse guifg=#080808")

--vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
--vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

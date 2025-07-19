require('Comment').setup({
  
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>/',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = '<C-/>',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = '<A-/>k',
        ---Add comment on the line below
        below = '<A-/>j',
        ---Add comment at the end of line
        eol = '<A-/>.',
    }

})

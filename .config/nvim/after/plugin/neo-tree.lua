local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true}

map("n", "<leader>t", "<Cmd>Neotree toggle<CR>", opts)

require("neo-tree").setup({

    icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
        },
   
})

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

--Telecope remembering my search once I do live_grep

local once = true

vim.keymap.set('n', '<leader>f', function ()
                                    if (once)
                                    then
                                        builtin.live_grep()
                                        once = false
                                    else
                                        builtin.resume()
                                    end
                                 end)

--Exiting Telescope with esc when I'm in insert mode

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

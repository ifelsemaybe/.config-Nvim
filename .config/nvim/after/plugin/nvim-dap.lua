local dap = require("dap")

local cwd = vim.fn.getcwd()

--C# debug

dap.adapters.coreclr = {

    type = 'executable',
    command = '/usr/bin/netcoredbg',
    args = {'--interpreter=vscode'}

}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

--neovimlua debug

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

--C/C++ (C is untested, could reuse the cpp configurations for Rust aswell!)

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/alex/src/ms-vscode.cpptools-1.21.0@linux-x64/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    setupCommands = {
    
        {
        
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false
        
        },
    },

  }
}

dap.configurations.c = dap.configurations.cpp;

--Python

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = cwd .. '/.venv/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.

  },
}

--JavaScript

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {"/home/alex/.local/share/nvim/tars/js-debug-dap-v1.91.0/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

local dapui = require("dapui")

dapui.setup{
    
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "console",
            size = 0.5
          }, {
            id = "repl",
            size = 0.5
          } },
        position = "bottom",
        size = 10
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
}


dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

--events to correctly resize window after opening/closing split

vim.api.nvim_create_augroup("DAP_UI_RESET", {clear = true})

local bufferNames = {}

vim.api.nvim_create_autocmd( {"BufWinEnter"},{ --onsplit event

    group = "DAP_UI_RESET",
    pattern = "*",

    callback = function()
        
        local bufferName = vim.fn.expand("%")

        if dap.session() and bufferName ~= "DAP Watches" and bufferName ~= "DAP Stacks" and bufferName ~= "DAP Breakpoints" and bufferName ~= "DAP Scopes" and bufferName ~= "DAP Console" and not string.find(bufferName, "%[dap%-repl%-", 1) and bufferName ~= "DAP Hover" and bufferName ~= "[dap-terminal] Launch file" then
            
            table.insert(bufferNames, vim.fn.expand("%:p")) --This takes the full path-"name" of each buffer.

            print("Buffer Name - " .. vim.fn.expand("%"))

            dapui.open({reset = true})

        end

    end
})

vim.api.nvim_create_autocmd({"BufUnload", "BufHidden"}, {

    group = "DAP_UI_RESET",
    pattern = "*",

    callback = function (args)


        if dap.session() then --First we find the Buffer nbr of each previously created split-Buffers. Second, we circle back and check that each of these buffers are still visible, and if not, we resize the window.

            for i = 1, #bufferNames do --First

                local index = -1

                for _, buf in ipairs(vim.api.nvim_list_bufs()) do

                    if bufferNames[i] == vim.api.nvim_buf_get_name(buf) then
                        
                        index = vim.api.nvim_buf_get_number(buf)

                        break

                    end

                end

                vim.schedule(function () --Second

                    if vim.fn.bufwinid(index) == -1 then --checks to see if window still exists in current tab, -1 means no.

                        table.remove(bufferNames, i)

                        dapui.open({reset = true})

                    end

                end)

            end

        end

    end

})

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939'})
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379'})

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='', numhl='DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text='▶️', texthl='DapStopped', linehl='', numhl= '' })

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

local cmp = require"cmp"

local luasnip = require"luasnip"

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()

    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"

end

local kind_icons = {
  Text = "󰊄",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "󰌆",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "󰉺",
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<A-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<S-CR>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping.confirm { select = true },
    ["<S-Tab>"] = cmp.mapping(function(fallback)
--      if cmp.selectable() then
--        cmp.mapping.confirm{select = true}
      if luasnip.expandable() then
        print("Hello expandable!")
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
       print("Hello ex or jumpable!")
       luasnip.expand_or_jump()
      elseif check_backspace() then
        print("Hello backspace!")
        fallback()
      else
        print("Hello Nothing!")
        fallback()
      end
    end, {
      "i",
      "s",
    }),
--    ["<S-Tab>"] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_prev_item()
--      elseif luasnip.jumpable(-1) then
--        luasnip.jump(-1)
--      else
--        fallback()
--      end
--    end, {
--      "i",
--      "s",
--    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua =  "[Nvim_Lua]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp"},
    { name = "nvim_lua"},
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    
    native_menu = false,

    ghost_text = true

  },
}


--Turn off completion when in the middle of editing a word


-- Consolidated list of characters that should toggle ghost_text

local toggle_chars = {
'"', "'", '`', '<', '>', '{', '}', '[', ']', '(', ')', ' ', ''
}

local cmp_config = require('cmp.config')

local function toggle_cmp()
    
    if vim.api.nvim_get_mode().mode ~= "i" then
        return
    end

    -- Get the current cursor column and line content
    local cursor_col = vim.fn.col('.')  -- Get cursor column
    local line = vim.fn.getline('.')    -- Get current line content

    -- Get the character after the cursor
    local char_after = line:sub(cursor_col, cursor_col)

    -- Check if the character after the cursor is in the toggle list (pair characters, spaces, or end of line)
    local should_enable_cmp = vim.tbl_contains(toggle_chars, char_after)

    -- Enable or disable cmp based on the condition

    cmp_config.set_onetime({
            
        enabled = should_enable_cmp

    })

end

vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
    callback = toggle_cmp,
})

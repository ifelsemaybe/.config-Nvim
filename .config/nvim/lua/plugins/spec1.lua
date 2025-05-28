return {

	{ --main colorscheme

		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false
	},

	{ --backup colorscheme

		"ellisonleao/gruvbox.nvim",
		lazy = false
	},

	{ --Help Find/Search text in files, update the tag # from time to time

		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependecies = { "nvim-lua/plenary.nvim" }
	},

	{ --Syntax Highlighting

		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},

	{ --Adding git diff symbols in margin

		"lewis6991/gitsigns.nvim"
	},

	{ --Nerd Font Icons for plugins

		"nvim-tree/nvim-web-devicons"
	},

	{ --Neovim tabline

		"romgrk/barbar.nvim"
	},

	{ --Indent guides

		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
	},

	{ --UI component library
	
		"MunifTanjim/nui.nvim"
	},

	{ --File explorer tree

		"nvim-tree/nvim-tree.lua"
	},

	{ --Statusline

		"nvim-lualine/lualine.nvim"
	},

	{ --Terminal

		"akinsho/toggleterm.nvim",
		version = "*",
		config = true
	},

	{ --Auto-completion

		"hrsh7th/nvim-cmp"
	},

	{ --Buffer completion

		"hrsh7th/cmp-buffer"
	},

	{ --Path completion

		"hrsh7th/cmp-path"
	},

	{ --Commandline completion

		"hrsh7th/cmp-cmdline"
	},

	{ --snippet completion

		"saadparwaiz1/cmp_luasnip"
	},

	{ --neovim lsp completion

		"hrsh7th/cmp-nvim-lsp"
	},

	{ --neovim lua API completion

		"hrsh7th/cmp-nvim-lua"
	},

	{ --snippet engine

		"L3MON4D3/LuaSnip",
		version = "v2.*"
	},

	{ --A variety of different snippets

		"rafamadriz/friendly-snippets"
	},

	{ --Nvim LSP

		"neovim/nvim-lspconfig"
	},

	{ --Package manager for LSP, DAP servers and linters, formatters

		"williamboman/mason.nvim"
	},

	{ --Extension to mason.nvim

		"williamboman/mason-lspconfig.nvim"
	},

	{ --Autopair for certain characters, i.e. ( or "

		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true
	},

	{ --I'm not sure what I use this for, maybe for Ctrl keybinds

		"assistcontrol/readline.nvim"
	},

	{ --Highlights colors

		"norcalli/nvim-colorizer.lua",
        config = function()
            vim.opt.termguicolors = true
        end
	},

	{ --Saves sessions when calling Neovim with no args, i.e. nvim

		"rmagatti/auto-session",
		lazy = false
	},

	{ --UI for DAP servers

		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
	},

	{ --Allows you to debug lua code inside of a running nvim instance

		"jbyuki/one-small-step-for-vimkind"
	}

}

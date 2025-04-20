-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"mbbill/undotree",
	{ "williamboman/mason.nvim",          },
	{ "williamboman/mason-lspconfig.nvim",},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} }
		},
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	"arzg/vim-colors-xcode",
	"vimpostor/vim-lumen",
	{
		"mfussenegger/nvim-dap",
		config = function(_, _)
			local dap = require("dap")
			dap.configurations.python = {
				{
					type = 'python',
					request = 'launch',
					name = "Current file",
					program = "${file}",
				},
			}

			dap.adapters.python = function(cb, config)
				if config.request == 'attach' then
					---@diagnostic disable-next-line: undefined-field
					local port = (config.connect or config).port
					---@diagnostic disable-next-line: undefined-field
					local host = (config.connect or config).host or '127.0.0.1'
					cb({
						type = 'server',
						port = assert(port,
							'`connect.port` is required for a python `attach` configuration'),
						host = host,
						options = {
							source_filetype = 'python',
						},
					})
				else
					cb({
						type = 'executable',
						command = "python",
						args = { '-m', 'debugpy.adapter' },
						options = {
							source_filetype = 'python',
						},
					})
				end
			end
		end

	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "console",
							size = 0.5
						},
						{
							id = "repl",
							size = 0.5
						}
					},
					position = "bottom",
					size = 10
				},
				{
					elements = {
						{
							id = "watches",
							size = 0.8
						},
						{
							id = "breakpoints",
							size = 0.2
						},
					},
					position = "left",
					size = 30
				},
			},
		},
		config = function(_, opts)
			local dapui, dap = require("dapui"), require('dap')
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- We may want to actually keep it open to state (such as logs at closing time)
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			dapui.setup(opts)
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		}
	},
	"tpope/vim-sleuth",
	{
		"olimorris/codecompanion.nvim",
		config = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"github/copilot.vim",
		},
	},
})

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Line numbers
vim.wo.number = true

-- Enable mouse support
vim.o.mouse = 'a'

-- Highlight to 100th column
vim.o.colorcolumn = '100'

-- Show relative line numbers
vim.o.relativenumber = true

-- Leave 10 lines before end of screen
vim.o.scrolloff = 10

-- Make sure search hits are highlighted
vim.o.hlsearch = true

-- Make sure inc search is on
vim.opt.incsearch = true

-- Break indent
vim.o.breakindent = true

-- Disable swap file
vim.opt.swapfile = false

-- Disable backups
vim.opt.backup = false

-- Restrict update time
vim.opt.updatetime = 100

-- Add undo dir
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- Smart search. Use capital to search case-sensitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- Sign column to be able to have line signs for things like debuggers
-- vim.wo.signcolumn = 'yes'

-- Smart indent
vim.opt.smartindent = true

-- Disable line wrap
vim.opt.wrap = false

-- Set colorscheme
vim.cmd [[colorscheme xcodehc]]

-- Tabs to three spaces (to notice when I use tabs)
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true


-------------
--- FUNCS --|
-------------
-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

----------------------
--- DEFAULT KEYMAP --|
----------------------
-- Strange keybind, never used.
vim.keymap.set("n", "Q", "<nop>")

-- Move highlight
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Add line below to the end of the current
vim.keymap.set("n", "J", "mzJ`z")

-- Delete and change does not add to clipboard
vim.keymap.set({ "n", "v" }, "d", "\"_d")
vim.keymap.set({ "n", "v" }, "c", "\"_c")

-- Retain selection when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Do nohlsearch when using escape
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR><Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>ef', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

---------------
--- PLUGINS --|
---------------
--> Treesitter
-- Borrowed from Kickstarter, defers treesitter execution
-- to allow opening specific files fast (nvim %file%)
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup {
		ensure_installed = { "javascript", "python", "lua", "html", "rust", "json", "go", "markdown" },
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		auto_install = false,
		modules = {},
		ignore_install = {},
	}
end, 0)

--> Telescope
local tbin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', tbin.find_files, {})
vim.keymap.set('n', '<C-p>', tbin.find_files, {})
vim.keymap.set('n', '<leader>fs', tbin.live_grep, {})
vim.keymap.set('n', '<leader>fb', tbin.buffers, {})
vim.keymap.set('n', '<leader>fh', tbin.help_tags, {})

--> Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

--> LSP zero
local lsp = require('lsp-zero')

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
	vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
end)

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'rust_analyzer',
		'pyright',
		'html',
		'gopls',
		'lemminx',
	},
	handlers = {
		lsp.default_setup,
	},
	automatic_installation = true
})

--> nvim-dap
local dap = require('dap')
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bc', dap.continue)
vim.keymap.set('n', '<leader>bn', dap.step_over)
vim.keymap.set('n', '<leader>bi', dap.step_into)
vim.keymap.set('n', '<leader>br', dap.repl.open)
vim.keymap.set('n', '<leader>bs', function() dap.disconnect({ terminateDebuggee = true }) end)
vim.keymap.set('n', '<leader>bl', require 'dap.ext.vscode'.load_launchjs)

vim.keymap.set('n', '<F8>', dap.continue)
vim.keymap.set('n', '<F9>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)

--> neotree
vim.keymap.set('n', '<leader>t', ":Neotree toggle<CR>")

--> codecompantion
require("codecompanion").setup({
	adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              -- model = {
              --   default = "gpt-4o",
              -- },
            },
          })
        end,
	}
})

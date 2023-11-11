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
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
     dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "javascript", "python", "c", "lua", "html", "rust" },
          sync_install = false,
          highlight = { enable = true, additional_vim_regs },
          indent = { enable = true },  
        })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = ' ',
      },
    }
  },
  'mbbill/undotree',
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'j-hui/fidget.nvim', tag = 'legacy', opts = {}}
    },
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {
    'romgrk/barbar.nvim',
     init = function() vim.g.barbar_auto_setup = false end,
     opts = {
       icons = { filetype = { enabled = false } },
       autohide = true,
       focus_on_close = 'previous',
       auto_hide = 1
       

    }
  },
  "github/copilot.vim",
  "arzg/vim-colors-xcode",
  "vimpostor/vim-lumen",
  "mfussenegger/nvim-dap",
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

-- Term colors (check if it actually work)
vim.o.termguicolors = true

-- Disable swap file
vim.opt.swapfile = false

-- Disable backups
vim.opt.backup = False

-- Restrict update time
vim.opt.updatetime = 100

-- Add undo dir
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

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
vim.cmd[[colorscheme xcode]]


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

-- Delete does not add to clipboard
vim.keymap.set({"n", "v"}, "d", "\"_d")

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

-- Close buffer
vim.keymap.set("n", "<leader>q", ":bd<CR>")

---------------
--- PLUGINS --|
---------------

--> Telescope
local tbin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', tbin.find_files, {})
vim.keymap.set('n', '<leader>fs', tbin.live_grep, {})
vim.keymap.set('n', '<leader>fb', tbin.buffers, {})
vim.keymap.set('n', '<leader>fh', tbin.help_tags, {})

--> Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

--> LSP zero
local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'pyright',
    'html',
  },
  handlers = {
    lsp.default_setup,
  },
})

--> nvim-dap
local dap = require('dap')
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bc', dap.continue)
vim.keymap.set('n', '<leader>bn', dap.step_over)
vim.keymap.set('n', '<leader>bi', dap.step_into)
vim.keymap.set('n', '<leader>bd', dap.repl.open)
vim.keymap.set('n', '<leader>bs', function() dap.disconnect({ terminateDebuggee = true }) end)
vim.keymap.set('n', '<leader>bl', require'dap.ext.vscode'.load_launchjs)

vim.keymap.set('n', '<F8>', dap.continue)
vim.keymap.set('n', '<F9>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)

-- Adapters
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
      -- TODO: Works on my computer! :D 
      command = '/Users/saleone/Dev/Me/Tools/venvs/venv-dap/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

-- Configurations
dap.configurations.python = {
  -- Only current file for global config
  {
    type = 'python';
    request = 'launch';
    name = "Current file";

    program = "${file}";
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      -- TODO: Write a lua function that recursively searches for folder
      -- named .venv-* and returns the path to the python executable
      -- TODO: Just use the Python from $PATH. Verify below is the case for that.
      return 'python'
    end
  },
}

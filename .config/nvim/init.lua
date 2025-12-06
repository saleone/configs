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
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} }
    },
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
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
               envFile = "${workspaceFolder}/.env",
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

      dapui.setup(opts)
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
  default_component_configs = {
      icon = {
        -- Maybe 📂
        folder_closed = "+",
        folder_open = "-",
        folder_empty = "~",
      }
    }
    }
  },
  "tpope/vim-sleuth",
  "leafOfTree/vim-svelte-plugin",
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  }
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
vim.defer_fn(function()
  -- Ghostty seems to not apply the theme on neovim load. Deffering 
  -- the command makes it work
  vim.cmd [[colorscheme xcodehc]]
end, 0)

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

-- Reload file when changed on disk  -- works
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
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
    ensure_installed = { "javascript", "typescript", "python", "lua", "html", "rust", "json", "go", "markdown", "svelte", "http" },
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

--> Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'pyright',
    'html',
    'gopls',
    'lemminx',
    'ts_ls',
    'svelte',
    'jsonls',
  },
  automatic_installation = true
})

--> LSP configuration using native Neovim v0.11+ functions
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure each language server using vim.lsp.config
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
  capabilities = capabilities,
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json' },
  capabilities = capabilities,
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('lemminx', {
  cmd = { 'lemminx' },
  filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
  root_markers = { '.git' },
  capabilities = capabilities,
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('svelte', {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_markers = { 'package.json', 'svelte.config.js', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
})

-- Enable all configured language servers
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('pyright')
vim.lsp.enable('html')
vim.lsp.enable('gopls')
vim.lsp.enable('lemminx')
vim.lsp.enable('ts_ls')
vim.lsp.enable('svelte')
vim.lsp.enable('jsonls')

-- LSP keymaps (set up for all buffers with LSP attached)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    
    -- Default LSP keymaps
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Custom keymaps
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts)

    vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>ll', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lR', vim.lsp.buf.references, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Workspace management
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

  end,
})

--> Completion setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

--> nvim-dap
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bc', dap.continue)
vim.keymap.set('n', '<leader>bt', dap.run_to_cursor)
vim.keymap.set('n', '<leader>bn', dap.step_over)
vim.keymap.set('n', '<leader>bi', dap.step_into)
vim.keymap.set('n', '<leader>br', dap.repl.open)
vim.keymap.set('n', '<leader>bs', function() 
  dap.disconnect({ terminateDebuggee = true }) 
  dapui.close()
end)
vim.keymap.set('n', '<leader>bl', require 'dap.ext.vscode'.load_launchjs)

vim.keymap.set('n', '<F8>', dap.continue)
vim.keymap.set('n', '<F9>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)

--> neotree
vim.keymap.set('n', '<leader>t', ":Neotree toggle<CR>")

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'loctvl842/monokai-pro.nvim'
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "cpp", "lua", "go", "python", "bash", "yaml" }, -- Add languages you want
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    }

    use {
	    "neovim/nvim-lspconfig",
    }

    -- Auto completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',     -- LSP source
            'hrsh7th/cmp-buffer',       -- buffer words
            'hrsh7th/cmp-path',         -- filesystem paths
            'hrsh7th/cmp-cmdline',      -- command line completion
            'L3MON4D3/LuaSnip',         -- snippet engine
            'saadparwaiz1/cmp_luasnip', -- snippet completion
        }
    }
    -- VimTeX plugin
    use 'lervag/vimtex'

end)

require("lspconfig").clangd.setup {}

-- TreeSitter Config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Telescope Config
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-S-p>', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Autocompletion Config
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go" },
  highlight = {
    enable = true,
  },
})

-- Bufferline
require("bufferline").setup{}

-- LSP
require("lspconfig").clangd.setup {}
require("lspconfig").gopls.setup {}
require("lspconfig").pyright.setup({
  on_attach = on_attach,
})

-- Enable vimtex
vim.g.vimtex_compiler_method = 'latexmk'  -- the recommended compiler
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1       -- enable SyncTeX support
vim.g.vimtex_view_skim_activate = 1   -- bring Skim to front after forward search


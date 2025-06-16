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

use({
    "kylechui/nvim-surround",
    tag = "*" -- Use for stability; omit to use `main` branch for the latest features
})

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

require("nvim-surround").setup({
    surrounds = {
        ["c"] = {
            add = function()
                local cfg = require("nvim-surround.config")
                local cmd = cfg.get_input("Command: ")
                return { { "\\" .. cmd .. "{" }, { "}" } }
            end,
            find = [=[\[^\{}%[%]]-%b{}]=],
            delete = [[^(\[^\{}]-{)().-(})()$]],
            change = {
                target = [[^\([^\{}]-)()%b{}()()$]],
                replacement = function()
                    local cfg = require("nvim-surround.config")
                    local cmd = cfg.get_input("Command: ")
                    return { { cmd }, { "" } }
                end
            },
        },
        ["m"] = {
            add = function()
                local cfg = require("nvim-surround.config")
                local cmd = "texttt"
                return { { "\\" .. cmd .. "{" }, { "}" } }
            end,
            find = [=[\[^\{}%[%]]-%b{}]=],
            delete = [[^(\[^\{}]-{)().-(})()$]],
            change = {
                target = [[^\([^\{}]-)()%b{}()()$]],
                replacement = function()
                    local cfg = require("nvim-surround.config")
                    local cmd = cfg.get_input("Command: ")
                    return { { cmd }, { "" } }
                end
            },
        },
        ["C"] = {
            add = function()
                local cfg = require("nvim-surround.config")
                local cmd, opts = cfg.get_input("Command: "), cfg.get_input("Options: ")
                return { { "\\" .. cmd .. "[" .. opts .. "]{" }, { "}" } }
            end,
            find = [[\[^\{}]-%b[]%b{}]],
            delete = [[^(\[^\{}]-%b[]{)().-(})()$]],
            change = {
                target = [[^\([^\{}]-)()%[(.*)()%]%b{}$]],
                replacement = function()
                    local cfg = require("nvim-surround.config")
                    local cmd, opts = cfg.get_input("Command: "), cfg.get_input("Options: ")
                    return { { cmd }, { opts } }
                end
            },
        },
        ["e"] = {
            add = function()
                local cfg = require("nvim-surround.config")
                local env = cfg.get_input("Environment: ")
                return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
            end,
            find = tex_find_environment,
            delete = [[^(\begin%b{})().*(\end%b{})()$]],
            change = {
                target = [[^\begin{(.-)()%}.*\end{(.-)()}$]],
                replacement = function()
                    local env = require("nvim-surround.config").get_input("Environment: ")
                    return { { env }, { env } }
                end,
            }
        },
        ["E"] = {
            add = function()
                local cfg = require("nvim-surround.config")
                local env, opts = cfg.get_input("Environment: "), cfg.get_input("Options: ")
                return { { "\\begin{" .. env .. "}[" .. opts .. "]" }, { "\\end{" .. env .. "}" } }
            end,
            find = tex_find_environment,
            delete = [[^(\begin%b{}%b[])().*(\end%b{})()$]],
            change = {
                target = [[^\begin%b{}%[(.-)()()()%].*\end%b{}$]],
                replacement = function()
                    local cfg = require("nvim-surround.config")
                    local env = cfg.get_input("Environment options: ")
                    return { { env }, { "" } }
                end,
            }
        },
    },
})

-- Enable vimtex
vim.g.vimtex_compiler_latexmk = {
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-shell-escape',
    },
}
vim.g.vimtex_compiler_method = 'latexmk -shell-escape'  -- the recommended compiler
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1       -- enable SyncTeX support
vim.g.vimtex_view_skim_activate = 1   -- bring Skim to front after forward search


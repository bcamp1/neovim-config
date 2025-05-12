-- Plugin Manager: 'packer.nvim' example (replace with your preferred plugin manager)
require('packer').startup(function()
  -- Plugin list
  use 'loctvl842/monokai-pro.nvim'
  -- use 'nvim-tree/nvim-web-devicons' -- Recommended (for colored icons)
  use 'ryanoasis/vim-devicons'  -- Icons without colors
  use 'akinsho/bufferline.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
end)

-- Basic Settings
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.number = true

-- Set colorscheme
vim.cmd('colorscheme monokai-pro')

-- Bufferline Setup (Bufferline configuration using Lua)
require("bufferline").setup{}

-- Treesitter Configuration (Lua setup)
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c" },
  highlight = {
    enable = true,
  },
}

-- Keymaps
vim.api.nvim_set_keymap('n', '<leader>ev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-y>', ':bd<CR>', { noremap = true, silent = true })


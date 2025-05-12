call plug#begin()
Plug 'loctvl842/monokai-pro.nvim'
"Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'ryanoasis/vim-devicons' " Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
call plug#end()

" Basic Settings
set tabstop=4
set expandtab
syntax on
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set termguicolors
colorscheme monokai-pro
set number
lua << EOF
require("bufferline").setup{}
EOF

" Key maps
nnoremap <leader>ev :e ~/.config/nvim/init.vim <CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim <CR> :PlugInstall <CR>
nnoremap <C-l> :bn <CR>
nnoremap <C-h> :bp <CR>


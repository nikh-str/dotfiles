"     /\-/\
"    /a a  \                                 _
"   =\ Y  =/-~~~~~~-,_______________________/ )
"     '^--'          ________________________/
"       \           / my nvim config
"       ||  |---'\  \
"      (_(__|   ((__|
"
"{{{---------------- Plugins----------------------------------
call plug#begin()

"Better syntax support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'lervag/vimtex'

" Start Screen
Plug 'glepnir/dashboard-nvim'
" Cool Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " lua

"Telescope (fzf)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-media-files.nvim'

" Intellisense
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
"File managers
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

Plug 'liuchengxu/vim-which-key'
Plug 'terrortylor/nvim-comment'
Plug 'tpope/vim-surround'		" e.g. cs[( inside [hi] to change it to (hi)
Plug 'jiangmiao/auto-pairs'
Plug 'phaazon/hop.nvim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'voldikss/vim-floaterm'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'liuchengxu/vista.vim' "tags
Plug 'sirver/ultisnips'
Plug 'norcalli/nvim-colorizer.lua'
" Color Picker  
Plug 'KabbAmine/vCoolor.vim' " alt-c to color pick 
Plug 'lukas-reineke/indent-blankline.nvim', {'branch' : 'lua'}

Plug 'gruvbox-community/gruvbox'
" Plug 'glepnir/zephyr-nvim'

Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'romgrk/barbar.nvim'
call plug#end()
"}}}

"{{{---------------general settings--------------------------
let mapleader=" "
let maplocalleader=","
set mouse=a
set hidden       " Required to keep multiple buffers open multiple buffers
set encoding=utf-8
set nocompatible
set pumheight=10    " Makes popup menu smaller
set nohlsearch
filetype plugin indent on  "Enabling Plugin & Indent
syntax on
set foldmethod=marker
set clipboard+=unnamedplus
set cursorline
set number relativenumber
set wildmode=longest,list,full		"autocompletion in command line (tab)
set wildmenu
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab  
set splitbelow splitright 
" set conceallevel=2
set nobackup                      " This is recommended by coc
set nowritebackup                 " This is recommended by coc
set updatetime=300                " Faster completion
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
set noswapfile
" set autochdir                   " Set working directory to current file
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=7
endif

if (has('termguicolors'))
  set termguicolors
endif

colorscheme darkforest
""---- hi(glight) settings---------------
autocmd VimEnter * hi Normal ctermbg=none guibg=none

"ensure .rmd etc fiels are read as markdown to have proper syntax..
nnoremap <localleader>t :VimwikiSearchTags 
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [
                     \{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
                     \{'path': '~/Documents/Notes/Papers/', 'syntax': 'markdown', 'ext':'.md'},]
" autocmd FileType vimwiki set ft=markdown

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufRead,BufNewFile *.md setlocal spell!


"}}}


"------------LaTeX settings------------------------
source $HOME/.config/nvim/plug-config/vimtex.vim
"-----------Other-Plug-configs---------------------
source $HOME/.config/nvim/plug-config/slime.vim

"----------Keys---------------------------------
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/which-key.vim

luafile ~/.config/nvim/lua/plugins/startscreen-config.lua
luafile ~/.config/nvim/lua/plugins/comment-config.lua
luafile ~/.config/nvim/lua/plugins/galaxyline-config.lua
luafile ~/.config/nvim/lua/plugins/nvimtree-config.lua
luafile ~/.config/nvim/lua/plugins/colorizer-config.lua
luafile ~/.config/nvim/lua/plugins/treesitter-config.lua
luafile ~/.config/nvim/lua/plugins/telescope-config.lua
luafile ~/.config/nvim/lua/plugins/compe-config.lua
luafile ~/.config/nvim/lua/plugins/hop-config.lua
luafile ~/.config/nvim/lua/plugins/rnvimr-config.lua
luafile ~/.config/nvim/lua/plugins/indentline-config.lua
"LSP
luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/lsp/vim-ls.lua
luafile ~/.config/nvim/lua/lsp/latex-ls.lua
luafile ~/.config/nvim/lua/lsp/python-ls.lua
luafile ~/.config/nvim/lua/lsp/julia-ls.lua
luafile ~/.config/nvim/lua/lsp/bash-ls.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
luafile ~/.config/nvim/lua/lsp/css-ls.lua



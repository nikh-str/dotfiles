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
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'		" e.g. cs[( inside [hi] to change it to (hi)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lervag/vimtex'

Plug 'liuchengxu/vim-which-key'
" Start Screen
Plug 'mhinz/vim-startify'
" Cool Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " lua

Plug 'majutsushi/tagbar' "f8 to see tags
Plug 'sirver/ultisnips'

Plug 'norcalli/nvim-colorizer.lua'

"Telescope (fzf)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

" Intellisense
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
" Plug 'kosayoda/nvim-lightbulb'

"File managers
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

Plug 'tpope/vim-commentary'      " to comment/uncomment with gcc +++
Plug 'jiangmiao/auto-pairs'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

" Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'glepnir/zephyr-nvim'

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
" set wildmenu
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab  
set splitbelow splitright 
set conceallevel=2
set nobackup                      " This is recommended by coc
set nowritebackup                 " This is recommended by coc
set updatetime=300                " Faster completion
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" set omnifunc=syntaxcomplete#Complete
" set autochdir                   " Set working directory to current file

"ensure .rmd etc fiels are read as markdown to have proper syntax..
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufRead,BufNewFile *.md setlocal spell!


" Pandoc and Notes 
command! -nargs=1 Ngrep lvimgrep "<args>" ~/Documents/Notes/**/*.txt
nnoremap <leader>[ :Ngrep

" let g:pandoc#filetypes#handled = ["pandoc", "markdown", "textile"]
" let g:pandoc#biblio#use_bibtool = 1
" let g:pandoc#completion#bib#mode = 'citeproc'
" let g:pandoc#biblio#bibs = ["$HOME/Documents/Notes/global.bib"]
"}}}

"{{{ --------------Python settings/coc-----------------
au BufNewFile,BufRead *.py   set foldmethod=indent

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"}}}

"------------LaTeX settings------------------------
source $HOME/.config/nvim/plug-config/vimtex.vim
"-----------Other-Plug-configs---------------------
source $HOME/.config/nvim/plug-config/startify.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/slime.vim
source $HOME/.config/nvim/plug-config/goyo.vim

"----------Keys---------------------------------
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/which-key.vim
"--------------Appearance-------------------
"my theme
" luafile ~/.config/nvim/themes/darkforest.lua
source $HOME/.config/nvim/themes/gruvbox.vim

luafile ~/.config/nvim/lua/plugins/galaxyline-config.lua
luafile ~/.config/nvim/lua/plugins/nvimtree-config.lua
luafile ~/.config/nvim/lua/plugins/colorizer-config.lua
luafile ~/.config/nvim/lua/plugins/treesitter-config.lua
luafile ~/.config/nvim/lua/plugins/telescope-config.lua
luafile ~/.config/nvim/lua/plugins/compe-config.lua
" luafile ~/.config/nvim/lua/plugins/lightbulb-config.lua
"LSP
luafile ~/.config/nvim/lua/lsp/vim-ls.lua
luafile ~/.config/nvim/lua/lsp/latex-ls.lua
luafile ~/.config/nvim/lua/lsp/python-ls.lua
luafile ~/.config/nvim/lua/lsp/julia-ls.lua
luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/lsp/bash-ls.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
luafile ~/.config/nvim/lua/lsp/css-ls.lua





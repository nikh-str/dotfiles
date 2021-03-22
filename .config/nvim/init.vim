
"{{{---------------- Plugins----------------------------------
call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
"Better syntax support
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'		" e.g. cs[( inside [hi] to change it to (hi)
Plug 'lervag/vimtex'
" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'
" Start Screen
Plug 'mhinz/vim-startify'
" Cool Icons
Plug 'ryanoasis/vim-devicons'
Plug 'majutsushi/tagbar' "f8 to see tags
Plug 'sirver/ultisnips'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'
"File managers
Plug 'preservim/nerdtree'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'     	  " to comment/uncomment with gcc +++
Plug 'jiangmiao/auto-pairs'
" Plug 'davidhalter/jedi-vim' " python autocompletion
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'jpalardy/vim-slime'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'
call plug#end()
"}}}

"{{{------ ---------general settings--------------------------
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
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" set autochdir                     " Set working directory to current file
"ensure .rmd etc fiels are read as markdown to have proper syntax..
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufRead,BufNewFile *.md setlocal spell!

let g:slime_target="tmux"
" let g:slime_target = "kitty"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_python_ipython = 1

let NERDTreeQuitOnOpen = 1 "close NERDTree window aftero opening a file from it


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
"----------Keys---------------------------------
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/which-key.vim
"
"--------------Appearance-------------------
source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/themes/airline.vim


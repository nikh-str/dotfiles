
"{{{---------------- Plugins----------------------------------
call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'		" e.g. cs[( inside [hi] to change it to (hi)
Plug 'lervag/vimtex'
Plug 'ryanoasis/vim-devicons'
Plug 'majutsushi/tagbar' "f8 to see tags
Plug 'sirver/ultisnips'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdtree'
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
call plug#end()
"}}}

"{{{------ ---------general settings--------------------------
let maplocalleader=" "
set mouse=a
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
"ensure .rmd etc fiels are read as markdown to have proper syntax..
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
 " configure Vim so that it sets the working directory to the current file's directory:
autocmd BufEnter * silent! lcd %:p:h
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufRead,BufNewFile *.md setlocal spell!

let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

let NERDTreeQuitOnOpen = 1 "close NERDTree window aftero opening a file from it


"}}}
"{{{---------------Key Remapping----------------------------
nmap <leader>f :Files<CR>
nmap <leader>h :History<CR>
map <leader>o :setlocal spell! spelllang=en,el<CR>
imap jj <Esc>
map <leader>nt :tabnew<CR> "to create a new tab
map <leader>ct :tabclose<CR> "to close a new tab
nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>ue :UltiSnipsEdit<CR>
" Open my bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Horizontal line movement
nnoremap <S-h> g^
nnoremap <S-l> g$
vnoremap <S-h> g^
vnoremap <S-l> g$


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <ctrl-j> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" <C-j>: completion. navigate
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
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
"
"--------------Appearance-------------------
source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/themes/airline.vim


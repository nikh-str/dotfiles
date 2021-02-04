"
" __   __(_)  __  __   _ ___ __
" \ \ / /  | '_ ' _  \| ` _/  _|
"  \ V / | | | | | | || |  | (_
"   \_/  |_|_| |_| |_||_|  \___|
let maplocalleader=" "
set mouse=a                             "to enable mouse in all modes
set number relativenumber
set encoding=UTF-8
set nocompatible 			" To enable Ultisnips...
set ttymouse=sgr			" to enable mouse in alacritty
set autoindent smartindent
set clipboard+=unnamedplus		"use system clipboard
set showtabline=2
set splitbelow                          " Horizontal splits will automatically be below
set smarttab 
" set expandtab				" to enter spaces when tab is pressed
set wildmode=longest,list,full		"autocompletion in command line (tab)
set ignorecase				"to ignore case when searching


syntax on

highlight Folded ctermbg=Black  ctermfg=Red 
filetype plugin on

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" map to access system's clipboard
vnoremap <C-c> "+y
map <C-p> "+p

" Spell Check
map <leader>o :setlocal spell! spelllang=en,el<CR>

"make jj do esq for insert mode"
imap jj <Esc>

"  necessary for backward search / ensures vim will start with server
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
"--------------------------------------------------
"		PLUGINS
"-------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'		" e.g. cs"' inside "hi" to change it to 'hi'
Plug 'lervag/vimtex'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'sirver/ultisnips'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'
Plug 'mboughaba/i3config.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'     	  " to comment/uncomment with gcc +++
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --rust-completer' }
Plug 'dylanaraps/wal.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'

call plug#end()
"----------------------------------------------------
" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>


let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Tabs & navigation
map <leader>nt :tabnew<CR> "to create a new tab
map <leader>tc :tabclose<CR> "to close a new tab

"ensure .rmd etc fiels are read as markdown to have proper syntax..
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]



" Map key to open NERDTree (Ctrl+n)
map <C-n> :NERDTreeToggle<CR>
"close NERDTree window aftero opening a file from it
let NERDTreeQuitOnOpen = 1

map <leader>ue :UltiSnipsEdit<CR>
" Open my bibliography file in split
map <leader>b :vsp<space>$BIB<CR>


" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor                      = 'latex'
let g:vimtex_view_metjod              = 'zathura'
let g:vimtex_fold_enabled             = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:UltiSnipsEditSplit              = "tabdo"
"let g:UltiSnipsListSnippets="<c-o>"

" make YCM compatible with UltiSnips (problem with Tab..)
let g:ycm_key_list_select_completion                = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion              = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType                 = '<C-n>'
let g:ycm_add_preview_to_completeopt                = 1
let g:ycm_autoclose_preview_window_after_insertion  = 1
let g:ycm_autoclose_preview_window_after_completion = 0
" Turn off YCM
nnoremap <leader>yc :let g:ycm_auto_trigger         = 0<CR>
" Turn on YCM
nnoremap <leader>Y :let g:ycm_auto_trigger          = 1<CR>

" for i3 syntax... (See plug)
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

" au BufNewFile,BufRead *.rmd set filetype=rmarkdown

 " configure Vim so that it sets the working directory to the current file's directory:
autocmd BufEnter * lcd %:p:h

let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}


"---------clean aux, log... files on exit vimtex------- 
augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
"----------------------------------------------------


"------------Pandoc Settings----------------"
let g:pandoc#command#custom_open = "MyPandocOpen"
" let g:pandoc#spell#enabled=0 " already toggle with <leader>o ... 
let g:pandoc#modules#disabled = ["folding", "spell"]

function! MyPandocOpen(file)
	let file = shellescape(fnamemodify(a:file, ':p'))
	let file_extension = fnamemodify(a:file, ':e')
	if file_extension is? 'pdf'
		if !empty($PDFVIEWER)
			return expand('$PDFVIEWER') . ' ' . file
		elseif executable('zathura')
			return 'zathura ' . file
		elseif executable('mupdf')
			return 'mupdf ' . file
		endif
	elseif file_extension is? 'html'
		if !empty($BROWSER)
			return expand('$BROWSER') . ' ' . file
		elseif executable('firefox')
			return 'firefox ' . file
		elseif executable('chromium')
			return 'chromium ' . file
		endif
	elseif file_extension is? 'odt' && executable('okular')
		return 'okular ' . file
	elseif file_extension is? 'epub' && executable('okular')
		return 'okular ' . file
	else
		return 'xdg-open ' . file
	endif
endfunction


"------------------------------------------------
"               Appearance
"-------------------------------------------------
set termguicolors
" colorscheme wal
" let g:gruvbox_italic=1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
" let g:gruvbox_transparent_bg=1
" let g:gruvbox_material_cursor = 'green'
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
set background=dark

"---- hi(glight) settings---------------
" Hilight Colors of SPELLCHECK
	highlight clear SpellBad
	highlight SpellBad ctermfg=Black  ctermbg=Yellow

set cursorline
hi CursorLine cterm=None ctermbg=black ctermfg=none guibg=#141214
" hi CursorLineNr term=bold cterm=bold ctermfg=magenta
" hi Visual cterm=none ctermbg=brown ctermfg=none
" hi MatchParen cterm=none ctermbg=yellow

"------------------------------------
hi VimwikiLink term=underline ctermfg=cyan guifg=cyan gui=underline
hi VimwikiHeader2 guifg=#e6c210

" " ----Cursor color settings..----------
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;magenta\x7"
  silent !echo -ne "\033]12;magenta\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

"----airline config--------------
" let g:airline_theme='distinguished'
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_buffers = 0

"enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

"needed to enable termguicolors in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"fixes rendering problem in kitty (devicons related)
set t_RV=

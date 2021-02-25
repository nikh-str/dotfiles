if (has('termguicolors'))
  set termguicolors
endif

let g:gruvbox_italic=1
colorscheme gruvbox

set background=dark

"---- hi(glight) settings---------------
" highlight clear SpellBad
" highlight SpellBad ctermfg=Black  ctermbg=Yellow
hi CursorLine ctermbg=black ctermfg=none guibg=#141214
hi Conceal cterm=None ctermfg=none ctermbg=none  guifg=none
" hi CursorLineNr term=bold cterm=bold ctermfg=magenta
hi Normal ctermbg=none guibg=none
hi Folded ctermbg=Black  ctermfg=Red guifg=#ad660a guibg=none

"------------------------------------
hi VimwikiLink term=underline ctermfg=red guifg=DarkCyan 
hi VimwikiHeader2 guifg=#e6c210 ctermfg=yellow cterm=bold

"needed to enable termguicolors in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif



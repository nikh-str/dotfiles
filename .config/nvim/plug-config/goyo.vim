 " Goyo
noremap <leader>g :Goyo<CR>

function! s:goyo_leave()
    hi Normal ctermbg=none guibg=none
    hi CursorLine ctermbg=black ctermfg=none guibg=#141214
    hi Conceal cterm=None ctermfg=none ctermbg=none  guifg=none
    " hi CursorLineNr term=bold cterm=bold ctermfg=magenta
    hi Normal ctermbg=none guibg=none
    hi Folded ctermbg=Black  ctermfg=Red guifg=#b16286 guibg=#141514
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()



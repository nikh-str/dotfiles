" let g:tex_flavor                      = 'latex' "already default
let g:vimtex_compiler_progname        = 'nvr'
let g:latex_view_general_viewer = "zathura"
let g:vimtex_view_method = "zathura"
let g:vimtex_fold_enabled             = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:UltiSnipsEditSplit              = "tabdo"
"let g:UltiSnipsListSnippets="<c-o>"
let g:tex_conceal='abdmgs'
let g:vimtex_log_ignore = [
        \ 'Underfull',
        \ 'Overfull',
        \]

augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END


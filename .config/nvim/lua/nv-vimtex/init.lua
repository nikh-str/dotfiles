vim.g.vimtex_compiler_programme = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.latex_view_general_method = "zathura"
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.tex_conceal = 'abdmgs'
-- vim.g.vimtex_log_ignore = [['Underfull', 'Overfull']]

-- Compile on initialization, cleanup on quit
vim.api.nvim_exec(
  [[
        augroup vimtex_event_1
            au!
            au User VimtexEventQuit     call vimtex#compiler#clean(0) 
        augroup END
    ]],
  false
)



local cmd = vim.cmd
local opt = vim.opt


cmd('filetype plugin on')
cmd('colorscheme darkforest')
-- Disable automatic commenting on new line
cmd([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python set foldmethod=indent
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufRead,BufNewFile *.md setlocal spell!  ]])
if O.transparent_window then
  cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
  else
      cmd "au ColorScheme * hi Normal ctermbg=none guibg=#0F0E0E"
end

cmd([[
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        hi Normal ctermbg=none guibg=#0F0E0E"
        let t:is_transparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>
]])




opt.ruler = false
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cul = true --cursorline
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 300 -- update interval for gitsigns
opt.clipboard = "unnamedplus"
-- opt.conceallevel    = 2
opt.fileencoding    = "utf-8"
opt.hidden          = true -- required to keep multiple buffers and open multiple buffers
opt.hlsearch        = false   -- highlight all matches on previous search pattern
opt.backup          = false
opt.writebackup     = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile        = false
opt.termguicolors   = true
opt.timeoutlen      = O.timeoutlen   -- time to wait for a mapped sequence to complete (in milliseconds)
opt.expandtab       = true                      -- convert tabs to spaces
opt.shiftwidth      = 4         -- the number of spaces inserted for each indentation
opt.tabstop         = 4                         -- insert 4 spaces for a tab
-- opt.cursorline      = O.cursorline              -- highlight the current line
opt.number          = true                -- set numbered lines
opt.relativenumber  = true
opt.signcolumn      = "yes"                     -- always show the sign column, otherwise it would shift the text each time
opt.wrap            = O.wrap_lines              -- display lines as one long line
opt.foldmethod      = "marker"
opt.autoindent      = true
opt.smartindent = true


cmd([[
let t:is_relative = 1
function! Toggle_relativenumbers()
    if t:is_relative == 0
        set relativenumber
        let t:is_relative = 1
    else
        set norelativenumber
        let t:is_relative = 0
    endif
endfunction
]])

-- set redrawtime=10000
-- set autochdir
-- set nocompatible
-- set pumheight=10    " Makes popup menu smaller
-- set nohlsearch
-- filetype plugin indent on  "Enabling Plugin & Indent
-- syntax on
-- set wildmode=longest,list,full		"autocompletion in command line (tab)
-- set wildmenu
-- if !&scrolloff
--   set scrolloff=1
-- endif
-- if !&sidescrolloff
--   set sidescrolloff=7
-- endif
--


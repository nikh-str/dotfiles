--   /\-/\
--  /a a  \                                 _
-- =\ Y  =/-~~~~~~-,_______________________/ )
---   '^--'          ________________________/
--     \           / my nvim config
--     ||  |---'\  \
--    (_(__|   ((__|
require("config.lazy")
require("globals")
require("opts")
require("mappings")
require("plugins")
require("nv-telescope")
require("nv-lualine")
-- require("nv-treesitter")
require("nv-which-key")
require("nv-neoroot")
-- TODO fix neorg and treesitter
-- require("neorg").setup()
require('Comment').setup()
require("nv-bufferline").config()
require("nv-rnvimr")
require("nv-vimtex")
require("nv-slime")
require("nv-colorizer")
require("nv-indentline")
-- require("nv-vimwiki")
require("nv-dashboard")
require("nv-toggleterm")
-- require("nv-gitsigns")
require("nv-neoclip")
-- LSP
require("lsp")
-- require("lsp.lua-ls")
require'lspconfig'.lua_ls.setup{}
require("lsp.bash-ls")
require("lsp.julia-ls")
require("lsp.python-ls")
require("lsp.vim-ls")
require("lsp.null-ls")
require("lsp.latex-ls")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}



-- require("nvim-treesitter.configs").setup({
-- ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "html" },
--           sync_install = false,
--           highlight = { enable = true },
--           indent = { enable = true },  
--           additional_vim_regex_highlighting = false,
--         })

-- 	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
-- 	autopairs = {
-- 		enable = true,
-- 	},
-- 	highlight = {
-- 		enable = true, -- false will disable the whole extension
-- 		disable = { "latex" }, --problem with vimtex conceal..
-- 	},
-- 	rainbow = { enable = true, extended_mode = true },
-- 	indent = { enable = true, disable = { "yaml" } },
-- })

-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- parser_configs.norg = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg",
-- 		files = { "src/parser.c", "src/scanner.cc" },
-- 		branch = "main",
-- 	},
-- }

-- parser_configs.norg_meta = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- }

-- parser_configs.norg_table = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- }

CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')
TERMINAL = vim.fn.expand('$TERMINAL')
--O is the global options object

O = {
    auto_close_tree = 0,
    auto_complete = true,
    hidden_files = true,
    wrap_lines = true,
    shell = 'bash',
    timeoutlen = 150,
    nvim_tree_disable_netrw = 0,
    ignore_case = true,
    transparent_window = true,
    smart_case = true,
    leader_key = ' ',


    treesitter = {
        ensure_installed = "all",
        highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "latex" }, --problem with vimtex conceal..
      },
      rainbow = {enable = true,
      extended_mode = true,
      },
    },

}


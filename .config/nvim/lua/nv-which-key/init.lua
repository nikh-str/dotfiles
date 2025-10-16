local wk = require("which-key")
local defaults = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      -- Delay before showing the popup. Can be a number or a function that returns a number.
      ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      ---@param mapping wk.Mapping
      filter = function(mapping)
        -- example to exclude mappings without a description
        -- return mapping.desc and mapping.desc ~= ""
        return true
      end,
      --- You can add any mappings here, or use `require('which-key').add()` later
      ---@type wk.Spec
      spec = {},
      -- show a warning when issues were detected with your mappings
      notify = true,
      -- Which-key automatically sets up triggers for your mappings.
      -- But you can disable this and setup the triggers manually.
      -- Check the docs for more info.
      ---@type wk.Spec
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      -- Start hidden and wait for a key to be pressed before showing the popup
      -- Only used by enabled xo mapping modes.
      ---@param ctx { mode: string, operator: string }
      defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      --@type wk.Win.opts
      win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        border = "single",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {10},
        wo = {10
          -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      ---@type (string|wk.Sorter)[]
      --- Mappings are sorted using configured sorters and natural sort of the keys
      --- Available sorters:
      --- * local: buffer-local mappings first
      --- * order: order of the items (Used by plugins like marks / registers)
      --- * group: groups last
      --- * alphanum: alpha-numerical first
      --- * mod: special modifier keys last
      --- * manual: the order the mappings were added
      --- * case: lower-case first
      sort = { "local", "order", "group", "alphanum", "mod" },
      ---@type number|fun(node: wk.Node):boolean?
      expand = 0, -- expand groups when <= n mappings
      -- expand = function(node)
      --   return not node.desc -- expand all nodes without a description
      -- end,
      -- Functions/Lua Patterns for formatting the labels
      ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" },
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        ellipsis = "…",
        -- set to false to disable all mapping icons,
        -- both those explicitly added in a mapping
        -- and those from rules
        mappings = true,
        --- See `lua/which-key/icons.lua` for more details
        --- Set to `false` to disable keymap icons from rules
        ---@type wk.IconRule[]|false
        rules = {},
        -- use the highlights from mini.icons
        -- When `false`, it will use `WhichKeyIcon` instead
        colors = true,
        -- used by key format
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          L = "",
          CR = "",
          g = "",
          Esc = "",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "",
          Space = "",
          Tab = "T ",
        },
      },
      show_help = true, -- show a help message in the command line for using WhichKey
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- disable WhichKey for certain buf types and file types.
      disable = {
        ft = {},
        bt = {},
      },
      debug = false, -- enable wk.log in the current directory
    }



--
-- Set leader
-- vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.maplocalleader = ","
vim.g.mapleader = " "

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

wk.add({
    { '<leader>H', ':let @/=""<CR>', mode = 'n', silent=true},
    { '<leader>r', ':RnvimrToggle<CR>',icon="", mode = 'n', silent=true},
    { '<leader>;', ':Dashboard<CR>', mode = 'n', silent=true},
    { '<leader>/', ":lua require('Comment.api').toggle.linewise.current()<CR>", mode = 'n', silent=true},
    { '<leader>/', "<ESC><CMD> lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = 'v', silent=true},
    { '<leader>v', "<C-W>v<CR>", mode = 'n', silent=true},
    { '<leader>h', "<C-W>s<CR>", mode = 'n', silent=true},
    { '<leader>gv', "<Plug>SnipRun", mode = 'v', silent=true},
})


wk.add({
    { "<leader>/", desc = "Comment", nowait = false, remap = false },
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = false, remap = false },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit", icon="", nowait = false, remap = false },
    { "<leader>s", "<cmd>w<CR>", desc = "write", nowait = false, remap = false },
    { "<leader>v", desc = "split right", nowait = false, remap = false },
    { "<leader>h", desc = "split below", nowait = false, remap = false },
    { "<leader>p", group = "Packer", nowait = false, remap = false },
    -- { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = false, remap = false },
    -- { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = false, remap = false },
    -- { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = false, remap = false },
    -- { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = false, remap = false },
    -- { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = false, remap = false },
    { "<leader>b", group = "Buffers", icon="", nowait = false, remap = false },
    { "<leader>bD", "<cmd>BufferOrderByDirectory<cr>", desc = "sort BufferLines automatically by directory", nowait = false, remap = false },
    { "<leader>bL", "<cmd>BufferOrderByLanguage<cr>", desc = "sort BufferLines automatically by language", nowait = false, remap = false },
    { "<leader>be", "<cmd>BufferCloseAllButCurrent<cr>", desc = "close all but current buffer", nowait = false, remap = false },
    { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find buffer", nowait = false, remap = false },
    { "<leader>bh", "<cmd>BufferCloseBuffersLeft<cr>", desc = "close all buffers to the left", nowait = false, remap = false },
    { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "jump to buffer", nowait = false, remap = false },
    { "<leader>bk", "<cmd>bdelete<cr>", desc = "kill buffer", nowait = false, remap = false },
    { "<leader>bl", "<cmd>BufferCloseBuffersRight<cr>", desc = "close all BufferLines to the right", nowait = false, remap = false },
    { "<leader>bw", "<cmd>BufferWipeout<cr>", desc = "wipeout buffer", nowait = false, remap = false },

    { "<leader>l", group = "LSP", nowait = false, remap = false },
    { "<leader>lA", "<cmd>Lspsaga range_code_action<cr>", desc = "Selected Action", nowait = false, remap = false },
    { "<leader>lD", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics", nowait = false, remap = false },
    { "<leader>lL", "<cmd>Lspsaga lsp_finder<cr>", desc = "LSP Finder", nowait = false, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = false, remap = false },
    { "<leader>lT", "<cmd>LspTypeDefinition<cr>", desc = "Type Definition", nowait = false, remap = false },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action", nowait = false, remap = false },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", nowait = false, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async = true}<cr>", desc = "Format", nowait = false, remap = false },
    { "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Doc", nowait = false, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = false, remap = false },
    { "<leader>lj", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev Diagnostic", nowait = false, remap = false },
    { "<leader>lk", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic", nowait = false, remap = false },
    { "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics", nowait = false, remap = false },
    { "<leader>lp", group = "Peek", nowait = false, remap = false },
    { "<leader>lpd", "<cmd>lua require('lsp.peek').Peek('definition')<cr>", desc = "Definition", nowait = false, remap = false },
    { "<leader>lpi", "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", desc = "Implementation", nowait = false, remap = false },
    { "<leader>lpt", "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", desc = "Type Definition", nowait = false, remap = false },
    { "<leader>lq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix", nowait = false, remap = false },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename", nowait = false, remap = false },
    { "<leader>ls", "<cmd> Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = false, remap = false },
    { "<leader>lx", "<cmd>cclose<cr>", desc = "Close Quickfix", nowait = false, remap = false },

    { '<leader>nn', ":lua require('vimnotes').open_note()<CR>", mode = 'n', remap=false},
    { '<leader>nl', ":lua require('vimnotes').list_notes()<CR>", mode = 'n', remap=false},
    { '<leader>ni', ":lua require('vimnotes').insert_link()<CR>", mode = 'n', silent=true},
    { '<leader>np', ":lua require('vimnotes').preview_link()<CR>", mode = 'n', silent=true},

    { "<leader>u", group = "Ultisnips", nowait = false, remap = false },
    { "<leader>ue", "<cmd>UltiSnipsEdit<cr>", desc = "UltisnipsEdit", nowait = false, remap = false },

    { "<leader>f", group = "Search", nowait = false, remap = false },
    { "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = false, remap = false },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = false, remap = false },
    { "<leader>fN", "<cmd>lua require'nv-telescope'.find_notes()<cr>", desc = "Notes", nowait = false, remap = false },
    { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = false, remap = false },
    { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = false, remap = false },
    { "<leader>fc", "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", desc = "clipboard", nowait = false, remap = false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = false, remap = false },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = false, remap = false },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps", nowait = false, remap = false },
    { "<leader>fn", "<cmd>lua require'nv-telescope'.nvim_config()<cr>", desc = "nvim conf", nowait = false, remap = false },
    { "<leader>fo", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = false, remap = false },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = false, remap = false },
    { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "sessions", nowait = false, remap = false },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Text", nowait = false, remap = false },

    { "<leader>g", group = "Git",icon ="", nowait = false, remap = false },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = false, remap = false },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = false, remap = false },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = false, remap = false },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = false, remap = false },
    { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = false, remap = false },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = false, remap = false },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = false, remap = false },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = false, remap = false },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = false, remap = false },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = false, remap = false },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = false, remap = false },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = false, remap = false },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = false, remap = false },

    { "<leader>t", group = "Toggle", nowait = false, remap = false },
    { "<leader>tr", "<cmd>call Toggle_relativenumbers()<cr>", desc = "Relative numbers", nowait = false, remap = false },
    { "<leader>ts", "<cmd>setlocal spell! spelllang=en,el<CR>", desc = "Spelling", nowait = false, remap = false },
    { "<leader>tt", "<cmd>SymbolsOutline<cr>", desc = "Document Tags", nowait = false, remap = false },
    { "<leader>tz", "<cmd>ZenMode<CR>", desc = "Zen", nowait = false, remap = false },


    { "<leader>d", group = "Debug", icon="", nowait = false, remap = false },
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", nowait = false, remap = false },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = false, remap = false },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = false, remap = false },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = false, remap = false },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = false, remap = false },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = false, remap = false },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = false, remap = false },
    { "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", desc = "Pause", nowait = false, remap = false },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = false, remap = false },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = false, remap = false },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = false, remap = false },
    { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = false, remap = false },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = false, remap = false },

    { "<leader>L", group = "LaTeX", icon="TeX", nowait = false, remap = false },
    { "<leader>Lc", "<cmd>VimtexCompile<cr>", desc = "Toggle Compilation Mode", nowait = false, remap = false },
    { "<leader>Lf", "<cmd>call vimtex#fzf#run()<cr>", desc = "Fzf Find", nowait = false, remap = false },
    { "<leader>Li", "<cmd>VimtexInfo<cr>", desc = "Project Information", nowait = false, remap = false },
    { "<leader>Ls", "<cmd>VimtexStop<cr>", desc = "Stop Project Compilation", nowait = false, remap = false },
    { "<leader>Lt", "<cmd>VimtexTocToggle<cr>", desc = "Toggle Table Of Content", nowait = false, remap = false },
    { "<leader>Lv", "<cmd>VimtexView<cr>", desc = "View PDF", nowait = false, remap = false },

    { "<leader>P", group = "Hop", nowait = false, remap = false },
    { "<leader>Pc", "<cmd>HopChar1<cr>", desc = "HopChar", nowait = false, remap = false },
    { "<leader>Pl", "<cmd>HopLine<cr>", desc = "HopLine", nowait = false, remap = false },
    { "<leader>Pw", "<cmd>HopWord<cr>", desc = "HopWord", nowait = false, remap = false },
    { "<leader>S", group = "Session", nowait = false, remap = false },
    { "<leader>Sl", "<cmd>SessionLoad<cr>", desc = "Load Session", nowait = false, remap = false },
    { "<leader>Ss", "<cmd>SessionSave<cr>", desc = "Save Session", nowait = false, remap = false },
    { "<leader>T", group = "Terminal", nowait = false, remap = false },
    { "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = false, remap = false },
    { "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = false, remap = false },
    { "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = false, remap = false },
    { "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", nowait = false, remap = false },
    { "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = false, remap = false },
    { "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", nowait = false, remap = false },

})

-- local wk = require("which-key")
-- wk.register(mappings, opts)
wk.setup(defaults)

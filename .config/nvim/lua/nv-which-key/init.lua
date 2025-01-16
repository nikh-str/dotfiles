require("which-key").setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
        ellipsis = "…"
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
})

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
-- no hl
vim.api.nvim_set_keymap("n", "<Leader>H", ':let @/=""<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>r", ":RnvimrToggle<CR>", { noremap = true, silent = true })

-- dashboard
vim.api.nvim_set_keymap("n", "<Leader>;", ":Dashboard<CR>", { noremap = true, silent = true })

-- Comments
-- vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>v", "<C-W>v<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<C-W>s<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true }) --see also mappings.lua
vim.api.nvim_set_keymap("v", "gv", "<Plug>SnipRun", { silent = true })

local mappings = {

	["/"] = "Comment",
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["s"] = { "<cmd>w<CR>", "write" },
	["H"] = "No Highlight",
	["v"] = "split right",
	["h"] = "split below",

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	b = {
		name = "Buffers",
		k = { "<cmd>bdelete<cr>", "kill buffer" },
		j = { "<cmd>BufferLinePick<cr>", "jump to buffer" },
		f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
		w = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
		e = {
			"<cmd>BufferCloseAllButCurrent<cr>",
			"close all but current buffer",
		},
		h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
		l = {
			"<cmd>BufferCloseBuffersRight<cr>",
			"close all BufferLines to the right",
		},
		D = {
			"<cmd>BufferOrderByDirectory<cr>",
			"sort BufferLines automatically by directory",
		},
		L = {
			"<cmd>BufferOrderByLanguage<cr>",
			"sort BufferLines automatically by language",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
		A = { "<cmd>Lspsaga range_code_action<cr>", "Selected Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		D = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async = true}<cr>", "Format" },
		h = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		j = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
		k = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
		L = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
		l = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
		-- p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
		p = {
			name = "Peek",
			d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Definition" },
			t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
			i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Implementation" },
		},
		q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
		r = { "<cmd>Lspsaga rename<cr>", "Rename" },
		T = { "<cmd>LspTypeDefinition<cr>", "Type Definition" },
		x = { "<cmd>cclose<cr>", "Close Quickfix" },
		s = { "<cmd> Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	u = {
		name = "Ultisnips",
		e = { "<cmd>UltiSnipsEdit<cr>", "UltisnipsEdit" },
	},
	f = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "clipboard" },
		C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		-- d = {
		--     "<cmd>Telescope lsp_document_diagnostics<cr>",
		--     "Document Diagnostics"
		-- },
		-- D = {
		--     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
		--     "Workspace Diagnostics"
		-- },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		-- m = {"<cmd>Telescope marks<cr>", "Marks"},
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		o = { "<cmd>Telescope commands<cr>", "Commands" },
		k = { "<cmd>Telescope keymaps<cr>", "keymaps" },
		n = { "<cmd>lua require'nv-telescope'.nvim_config()<cr>", "nvim conf" },
		N = { "<cmd>lua require'nv-telescope'.find_notes()<cr>", "Notes" },
		s = { "<cmd>Telescope session-lens search_session<cr>", "sessions" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	t = {
		name = "Toggle",
		s = { "<cmd>setlocal spell! spelllang=en,el<CR>", "Spelling" },
		z = { "<cmd>ZenMode<CR>", "Zen" },
		t = { "<cmd>SymbolsOutline<cr>", "Document Tags" },
		r = { "<cmd>call Toggle_relativenumbers()<cr>", "Relative numbers" },
	},
	-- g = {
	-- 	name = "SnipRun",
	-- 	g = { "<cmd>SnipRun<cr>", "SnipRun" },
	-- 	c = { "<cmd>SnipClose<cr>", "SnipClose" },
	-- },

	P = {
		name = "Hop",
		w = { "<cmd>HopWord<cr>", "HopWord" },
		l = { "<cmd>HopLine<cr>", "HopLine" },
		c = { "<cmd>HopChar1<cr>", "HopChar" },
	},
	S = {
		name = "Session",
		s = { "<cmd>SessionSave<cr>", "Save Session" },
		l = { "<cmd>SessionLoad<cr>", "Load Session" },
	},

	L = {
		name = "LaTeX",
		c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
		f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
		i = { "<cmd>VimtexInfo<cr>", "Project Information" },
		s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
		t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
		v = { "<cmd>VimtexView<cr>", "View PDF" },
	},
	T = {
		name = "Terminal",
		-- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	d = {
		name = "Debug",
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
	},
}

local wk = require("which-key")
wk.register(mappings, opts)

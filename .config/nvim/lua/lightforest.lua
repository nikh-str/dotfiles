-- Theme:  darkforest
-- fork of: http://github.com/glepnir/zephyr-nvim
local darkforest = {
	base0 = "#F5B688",
	base1 = "#F5B688",
	base2 = "#F5B688",
	base3 = "#F5B688",
	base4 = "#F3AD79",
	base5 = "#CE9440",
	base6 = "#828066",
	base7 = "#9ca0a4",
	base8 = "#b1b1b1",

	bg = "#EFD4B1",
	bg1 = "#E1944C",
	bg_popup = "#E5C198",
	bg_highlight = "#E5C198",
	bg_cursorline = "#E5C69F",
	-- bg_visual = '#2c6656';
	bg_visual = "#F4B854",

	fg = "#4B2334",
	fg_alt = "#ebdbb2",

	red = "#af3a1f",
	redwine = "#722132",
	orange = "#AA6736",
	yellow = "#ECB457",

	green = "#689d6a",
	light_green = "#60A453",
	dark_green = "#98be65",

	cyan = "#2c6656",
	blue = "#458588",
	violet = "#aa7080",
	magenta = "#b16286",
	teal = "#3ca896",
	grey = "#928374",
	brown = "#c78665",
	black = "#000000",

	bracket = "#d88913",
	currsor_bg = "#4f5b66",
	sidebar_bg = "#E8C495",
	buf_sel = "#E3B981",
	buf_vis = "#E5C69F",
	statusline = "#E5C69F",
	none = "NONE",
}

function darkforest.terminal_color()
	vim.g.terminal_color_0 = darkforest.bg
	vim.g.terminal_color_1 = darkforest.red
	vim.g.terminal_color_2 = darkforest.green
	vim.g.terminal_color_3 = darkforest.yellow
	vim.g.terminal_color_4 = darkforest.blue
	vim.g.terminal_color_5 = darkforest.violet
	vim.g.terminal_color_6 = darkforest.cyan
	vim.g.terminal_color_7 = darkforest.bg1
	vim.g.terminal_color_8 = darkforest.brown
	vim.g.terminal_color_9 = darkforest.red
	vim.g.terminal_color_10 = darkforest.green
	vim.g.terminal_color_11 = darkforest.yellow
	vim.g.terminal_color_12 = darkforest.blue
	vim.g.terminal_color_13 = darkforest.violet
	vim.g.terminal_color_14 = darkforest.cyan
	vim.g.terminal_color_15 = darkforest.fg
end

function darkforest.highlight(group, color)
	local style = color.style and "gui=" .. color.style or "gui=NONE"
	local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
	local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
	-- local bg = color.bg and "guibg=NONE" .. color.bg or "guibg=NONE"
	local sp = color.sp and "guisp=" .. color.sp or ""
	vim.api.nvim_command("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp)
end

function darkforest.load_syntax()
	local syntax = {
		Normal = { fg = darkforest.fg, bg = darkforest.bg }, -- also changes buffer fill
		Terminal = { fg = darkforest.fg, bg = darkforest.bg },
		SignColumn = { fg = darkforest.fg, bg = darkforest.none },
		FoldColumn = { fg = darkforest.fg_alt, bg = darkforest.black },
		VertSplit = { fg = darkforest.base1, bg = darkforest.sidebar_bg },
		Folded = { fg = darkforest.teal, bg = darkforest.none },
		EndOfBuffer = { fg = darkforest.bg, bg = darkforest.none },
		IncSearch = { fg = darkforest.bg1, bg = darkforest.orange, style = darkforest.none },
		Search = { fg = darkforest.bg, bg = darkforest.orange },
		ColorColumn = { fg = darkforest.none, bg = darkforest.bg_highlight },
		Conceal = { fg = darkforest.grey, bg = darkforest.none },
		Cursor = { fg = darkforest.none, bg = darkforest.none, style = "reverse" },
		vCursor = { fg = darkforest.none, bg = darkforest.none, style = "reverse" },
		iCursor = { fg = darkforest.none, bg = darkforest.none, style = "reverse" },
		lCursor = { fg = darkforest.none, bg = darkforest.none, style = "reverse" },
		CursorIM = { fg = darkforest.none, bg = darkforest.none, style = "reverse" },
		CursorColumn = { fg = darkforest.none, bg = darkforest.bg_cursorline },
		CursorLine = { fg = darkforest.none, bg = darkforest.bg_cursorline },
		LineNr = { fg = darkforest.base4 },
		CursorLineNr = { fg = darkforest.blue },
		DiffAdd = { fg = darkforest.black, bg = darkforest.dark_green },
		DiffChange = { fg = darkforest.black, bg = darkforest.yellow },
		DiffDelete = { fg = darkforest.black, bg = darkforest.red },
		DiffText = { fg = darkforest.black, bg = darkforest.fg },
		Directory = { fg = darkforest.bg1, bg = darkforest.none },
		ErrorMsg = { fg = darkforest.red, bg = darkforest.none, style = "bold" },
		WarningMsg = { fg = darkforest.yellow, bg = darkforest.none, style = "bold" },
		ModeMsg = { fg = darkforest.fg, bg = darkforest.none, style = "bold" },
		MatchParen = { style = "bold", bg = darkforest.base4, fg = darkforest.none },
		NonText = { fg = darkforest.bg1 },
		Whitespace = { fg = darkforest.base4 },
		SpecialKey = { fg = darkforest.bg1 },
		Pmenu = { fg = darkforest.fg, bg = darkforest.bg_popup },
		PmenuSel = { fg = darkforest.base0, bg = darkforest.blue },
		PmenuSelBold = { fg = darkforest.base0, g = darkforest.blue },
		PmenuSbar = { fg = darkforest.none, bg = darkforest.base4 },
		PmenuThumb = { fg = darkforest.violet, bg = darkforest.light_green },
		WildMenu = { fg = darkforest.fg, bg = darkforest.green },
		Question = { fg = darkforest.yellow },
		NormalFloat = { fg = darkforest.base8, bg = darkforest.bg_highlight },
		FloatBorder = { fg = darkforest.cyan, bg = darkforest.none },
		TabLineFill = { bg = darkforest.base5 },
		TabLineSel = { style = "bold", bg = darkforest.buf_bg, fg = darkforest.violet },
		SepVisible = { fg = darkforest.cyan },
		BufSep = { fg = darkforest.red, bg = darkforest.buf_sel },
		BufSel = { fg = darkforest.magenta, bg = darkforest.buf_sel, style = "bold" },
		BufVis = { fg = darkforest.base5, bg = darkforest.buf_vis },
		BufferClose = { bg = darkforest.base3, fg = darkforest.red },
		StatusLine = { fg = darkforest.base8, bg = darkforest.statusline, style = darkforest.none },
		Tabline = { fg = darkforest.grey, bg = darkforest.statusline, style = darkforest.none },
		StatusLineNC = { fg = darkforest.grey, bg = darkforest.statusline, style = darkforest.none },
		SpellBad = { fg = darkforest.fg, bg = darkforest.none, style = "undercurl" },
		SpellCap = { fg = darkforest.blue, bg = darkforest.none, style = "undercurl" },
		SpellLocal = { fg = darkforest.cyan, bg = darkforest.none, style = "undercurl" },
		SpellRare = { fg = darkforest.fg, bg = darkforest.none, style = "undercurl" },
		Visual = { style = darkforest.none, bg = darkforest.bg_visual },
		VisualNOS = { fg = darkforest.black, bg = darkforest.bg_visual },
		QuickFixLine = { fg = darkforest.violet, style = "bold" },
		Debug = { fg = darkforest.orange },
		debugBreakpoint = { fg = darkforest.bg, bg = darkforest.red },

		Boolean = { fg = darkforest.orange },
		Number = { fg = darkforest.brown },
		Float = { fg = darkforest.brown },
		PreProc = { fg = darkforest.violet },
		PreCondit = { fg = darkforest.violet },
		Include = { fg = darkforest.violet },
		Define = { fg = darkforest.violet },
		Conditional = { fg = darkforest.magenta },
		Repeat = { fg = darkforest.magenta },
		Keyword = { fg = darkforest.green, style = "bold" },
		Typedef = { fg = darkforest.red, style = "bold" },
		Exception = { fg = darkforest.red },
		Statement = { fg = darkforest.red },
		Error = { fg = darkforest.red },
		StorageClass = { fg = darkforest.orange },
		Tag = { fg = darkforest.orange },
		Label = { fg = darkforest.orange },
		Structure = { fg = darkforest.teal },
		Operator = { fg = darkforest.orange },
		Title = { fg = darkforest.teal, style = "bold" },
		Special = { fg = darkforest.orange },
		SpecialChar = { fg = darkforest.magenta },
		Type = { fg = darkforest.teal },
		Function = { fg = darkforest.violet },
		String = { fg = darkforest.light_green },
		Character = { fg = darkforest.green },
		Constant = { fg = darkforest.cyan },
		Macro = { fg = darkforest.cyan },
		Identifier = { fg = darkforest.blue },
		--Symbols Outline
		FocusedSymbol = { bg = darkforest.cyan, fg = darkforest.teal, style = "bold" },

		Comment = { fg = darkforest.base5, style = "italic" },
		SpecialComment = { fg = darkforest.grey },
		Todo = { fg = darkforest.orange, bg=darkforest.yellow, style="bold" },
		Delimiter = { fg = darkforest.fg },
		Ignore = { fg = darkforest.grey },
		Underlined = { fg = darkforest.none, style = "underline" },

		DashboardShortCut = { fg = darkforest.magenta },
		DashboardHeader = { fg = darkforest.cyan },
		DashboardCenter = { fg = darkforest.orange },
		DashboardFooter = { fg = darkforest.yellow, style = "bold" },
	}
	return syntax
end

function darkforest.load_plugin_syntax()
	local plugin_syntax = {
		TSFunction = { fg = darkforest.red, style = "bold" },
		TSMethod = { fg = darkforest.cyan },
		TSKeywordFunction = { fg = darkforest.red },
		TSProperty = { fg = darkforest.magenta },
		TSType = { fg = darkforest.green },
		TSPunctBracket = { fg = darkforest.bracket },

		vimCommentTitle = { fg = darkforest.grey, style = "bold" },
		vimLet = { fg = darkforest.orange },
		vimVar = { fg = darkforest.cyan },
		vimFunction = { fg = darkforest.redwine },
		vimIsCommand = { fg = darkforest.yellow },
		vimCommand = { fg = darkforest.red, style = "bold" },
		vimNotFunc = { fg = darkforest.violet, style = "bold" },
		vimUserFunc = { fg = darkforest.violet, style = "bold" },
		vimFuncName = { fg = darkforest.teal, style = "bold" },

		diffAdded = { fg = darkforest.dark_green },
		diffRemoved = { fg = darkforest.red },
		diffChanged = { fg = darkforest.blue },
		diffOldFile = { fg = darkforest.yellow },
		diffNewFile = { fg = darkforest.orange },
		diffFile = { fg = darkforest.aqua },
		diffLine = { fg = darkforest.grey },
		diffIndexLine = { fg = darkforest.violet },

		gitcommitSummary = { fg = darkforest.red },
		gitcommitUntracked = { fg = darkforest.grey },
		gitcommitDiscarded = { fg = darkforest.grey },
		gitcommitSelected = { fg = darkforest.grey },
		gitcommitUnmerged = { fg = darkforest.grey },
		gitcommitOnBranch = { fg = darkforest.grey },
		gitcommitArrow = { fg = darkforest.grey },
		gitcommitFile = { fg = darkforest.dark_green },

		VistaBracket = { fg = darkforest.grey },
		VistaChildrenNr = { fg = darkforest.orange },
		VistaKind = { fg = darkforest.purpl },
		VistaScope = { fg = darkforest.red },
		VistaScopeKind = { fg = darkforest.blue },
		VistaTag = { fg = darkforest.magenta, style = "bold" },
		VistaPrefix = { fg = darkforest.grey },
		VistaColon = { fg = darkforest.magenta },
		VistaIcon = { fg = darkforest.yellow },
		VistaLineNr = { fg = darkforest.fg },

		GitGutterAdd = { fg = darkforest.dark_green },
		GitGutterChange = { fg = darkforest.blue },
		GitGutterDelete = { fg = darkforest.red },
		GitGutterChangeDelete = { fg = darkforest.violet },

		GitSignsAdd = { fg = darkforest.dark_green },
		GitSignsChange = { fg = darkforest.orange },
		GitSignsDelete = { fg = darkforest.red },

		SignifySignAdd = { fg = darkforest.dark_green },
		SignifySignChange = { fg = darkforest.blue },
		SignifySignDelete = { fg = darkforest.red },

		dbui_tables = { fg = darkforest.blue },

		DiagnosticSignError = { fg = darkforest.red },
		DiagnosticSignWarn = { fg = darkforest.yellow },
		DiagnosticSignInfo = { fg = darkforest.blue },
		DiagnosticSignHint = { fg = darkforest.cyan },

		DiagnosticVirtualTextError = { fg = darkforest.red },
		DiagnosticVirtualTextWarning = { fg = darkforest.base4 },
		DiagnosticVirtualTextInformation = { fg = darkforest.blue },
		DiagnosticVirtualTextHint = { fg = darkforest.cyan },

		LspDiagnosticsUnderlineError = { style = "undercurl", sp = darkforest.red },
		LspDiagnosticsUnderlineWarning = { style = "undercurl", sp = darkforest.yellow },
		LspDiagnosticsUnderlineInformation = { style = "undercurl", sp = darkforest.blue },
		LspDiagnosticsUnderlineHint = { style = "undercurl", sp = darkforest.cyan },

		CursorWord0 = { bg = darkforest.currsor_bg },
		CursorWord1 = { bg = darkforest.currsor_bg },

		NvimTreeNormal = { bg = darkforest.sidebar_bg },
		NvimTreeFolderName = { fg = darkforest.magenta },
		NvimTreeRootFolder = { fg = darkforest.red, style = "bold" },
		NvimTreeSpecialFile = { fg = darkforest.green, bg = darkforest.none, style = "NONE" },
		NvimTreeFolderIcon = { fg = darkforest.blue },

		TelescopeBorder = { fg = darkforest.magenta , style="bold"},
		TelescopePromptBorder = { fg = darkforest.red },
		TelescopeMatching = { fg = darkforest.teal },
		TelescopeSelection = { fg = darkforest.violet, bg = darkforest.bg_highlight, style = "bold" },
		TelescopeSelectionCaret = { fg = darkforest.orange },
		TelescopeMultiSelection = { fg = darkforest.teal },

		VimwikiHeader1 = { fg = darkforest.orange, style = "bold" },
		VimwikiHeader2 = { fg = darkforest.red, style = "bold" },
		VimwikiHeader3 = { fg = darkforest.violet, style = "bold" },
		VimwikiLink = { fg = darkforest.blue },

		texCmdEnv = { fg = darkforest.red, style = "bold" },
		texMathCmd = { fg = darkforest.violet },
		texCmdRef = { fg = darkforest.green, style = "bold" },
		texCmdPart = { fg = darkforest.red, style = "bold" },
		texPartArgTitle = { fg = darkforest.green, style = "bold" },
		texMathEnvArgName = { fg = darkforest.green },
	}
	return plugin_syntax
end

local async_load_plugin

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
	darkforest.terminal_color()
	local syntax = darkforest.load_plugin_syntax()
	for group, colors in pairs(syntax) do
		darkforest.highlight(group, colors)
	end
	async_load_plugin:close()
end))

function darkforest.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"
	vim.o.termguicolors = true
	vim.g.colors_name = "darkforest"
	local syntax = darkforest.load_syntax()
	for group, colors in pairs(syntax) do
		darkforest.highlight(group, colors)
	end
	async_load_plugin:send()
end

darkforest.colorscheme()

return darkforest

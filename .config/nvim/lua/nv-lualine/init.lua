local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end
-- local my_theme = require('../darkforest.lua')

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local colors = {
	bg = "#050505",
	yellow = "#A47F28",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#608B4E",
	orange = "#FF8800",
	purple = "#A6397A",
	magenta = "#d3869b",
	brown = "#C63216",
	grey = "#928374",
	blue = "#569CD6",
	red = "#cc241d",
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	-- colored = true,
	-- color = {},
	diagnostics_color = {
		error = { fg = colors.red, bg = colors.bg },
		warn = { fg = colors.yellow, bg = colors.bg },
		info = { fg = colors.cyan, bg = colors.bg },
	},
	-- update_in_insert = false,
	-- always_visible = true,
}

local diff = {
	"diff",
	symbols = { added = "  ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.yellow },
		removed = { fg = colors.red },
	},
	color = {},
	cond = conditions.hide_in_width,
}

local mode = {
	"mode",
	fmt = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.purple,
			i = colors.green,
			v = colors.magenta,
			[""] = colors.magenta,
			V = colors.magenta,
			c = colors.blue,
			no = colors.magenta,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.red,
			Rv = colors.red,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		vim.api.nvim_command("hi LualineMode guifg=" .. mode_color[vim.fn.mode()]) --.. " guibg=" .. colors.bg)
		vim.api.nvim_command("hi LualineFilename guifg=" .. colors.grey .. " guibg=" .. colors.bg)
		return "▊  Nvim"
	end,
	color = "LualineMode",
	padding = { right = 1 },
}

local filetype = {
	"filetype",
	cond = conditions.hide_in_width,
	icons_enabled = true,
	icon = nil,
	color = { fg = colors.brown, gui = "bold" },
}

local filename = {
	"filename",
	-- cond = conditions.buffer_not_empty,
	color = { fg = colors.grey },
	-- color = "LualineFilename",
    shorting_target = 140,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
	color = { fg = colors.grey, gui = "bold" },
}

local lsp_server = {
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.cyan, gui = "bold" },
}

local location = {
	"location",
	padding = 0,
	color = { fg = colors.green, gui = "bold" },
}

-- cool function for progress
local progress = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end,
	color = { fg = colors.green, gui = "bold" },
}

-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			-- normal = { c = { fg = colors.fg, bg = colors.bg } },
			-- inactive = { c = { fg = colors.fg, bg = colors.bg } },
		-- },
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode, diagnostics },
		lualine_b = { },
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = {filename, branch, diff, lsp_server, filetype, location, progress },
		lualine_y = { },
		lualine_z = {  },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

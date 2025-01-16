-- vim.g.dashboard_default_executive = 'telescope'

-- vim.g.dashboard_custom_section = {
--     a = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
--     b = {description = {'  Find File          '}, command = 'Telescope find_files'},
--     c = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
--     d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
--     e = {description = {'  Settings           '}, command = ':e ~/.config/nvim/init.vim'}
--     -- e = {description = {'  Marks              '}, command = 'Telescope marks'}
-- }

-- -- file_browser = {description = {' File Browser'}, command = 'Telescope find_files'},

-- -- vim.g.dashboard_custom_shortcut = {
-- --     a = 'f',
-- --     find_word = 'SPC f a',
-- --     last_session = 'SPC s l',
-- --     new_file = 'SPC c n',
-- --     book_marks = 'SPC f b'
-- -- }
-- -- find_history = 'SPC f h',

-- -- vim.g.dashboard_session_directory = '~/.cache/nvim/session'
-- vim.g.dashboard_custom_footer = {'Tu, tu ruu!'}

local home = os.getenv("HOME")
local db = require("dashboard")
-- linux
-- db.preview_command = "ueberzug"
--
-- db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
db.custom_header = {
	-- '          ▀████▀▄▄              ▄█ ',
	-- '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
	-- '    ▄        █          ▀▀▀▀▄  ▄▀  ',
	-- '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
	-- '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
	-- '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
	-- '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
	-- '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
	-- '   █   █  █      ▄▄           ▄▀   ',
	-- }
	"  ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}
db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "r",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "f",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		action = "Telescope live_grep",
		shortcut = "w",
	},
	{
		icon = "  ",
		desc = "Recently latest session                  ",
		shortcut = "s",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Open Personal dotfiles                  ",
		action = ":e ~/.config/nvim/init.lua",
		shortcut = "e",
	},
}

local actions = require("telescope.actions")
-- Global remapping
------------------------------
require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.75,
			prompt_position = "bottom",
			preview_cutoff = 120,
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		file_sorter = require("telescope.sorters").get_fzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "smart" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				-- To disable a keymap, put [map] = false
				-- So, to not map "<C-n>", just put
				-- ["<c-x>"] = false,
				["<esc>"] = actions.close,
				-- Otherwise, just set the mapping to the function that you want it to be.
				-- ["<C-i>"] = actions.select_horizontal,

				-- Add up multiple actions
				["<CR>"] = actions.select_default + actions.center,

				-- You can perform as many actions in a row as you like
				-- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				-- ["<esc>"] = actions.close,
				-- ["<C-i>"] = my_cool_custom_action,
			},
		},
	},
	--  extensions = {
	--     media_files = {
	--         -- filetypes whitelist
	--         -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
	--         filetypes = {"png", "webp", "jpg", "jpeg", "pdf"},
	--         find_cmd = "rg" -- find command (defaults to `fd`)
	--       }
	-- }
})
-- require('telescope').load_extension('media_files')

local M = {}

function M.nvim_config()
	require("telescope.builtin").file_browser({
		prompt_title = " NVim Config Browse",
		shorten_path = false,
		cwd = "~/.config/nvim",
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.65, width = 0.75 },
	})
end

function M.find_notes()
	require("telescope.builtin").find_files({
		prompt_title = " Find Notes",
		shorten_path = false,
		cwd = "~/Documents/vimwiki/",
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.65, width = 0.75 },
	})
end

return M

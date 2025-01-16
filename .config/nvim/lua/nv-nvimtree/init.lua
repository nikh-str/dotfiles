local M = {}

M.config = function()
	vim.g.nvim_tree_icons = {
		default = "",
		symlink = "",
		git = {
			unstaged = "",
			staged = "S",
			unmerged = "",
			renamed = "➜",
			deleted = "",
			untracked = "U",
			ignored = "◌",
		},
		folder = {
			default = "",
			open = "",
			empty = "",
			empty_open = "",
			symlink = "",
		},
	}
end

local view = require("nvim-tree.view")

M.toggle_tree = function()
	if view.win_open() then
		require("nvim-tree").close()
		if package.loaded["bufferline.state"] then
			require("bufferline.state").set_offset(0)
		end
	else
		if package.loaded["bufferline.state"] then
			-- require'bufferline.state'.set_offset(31, 'File Explorer')
			require("bufferline.state").set_offset(31, "")
		end
		require("nvim-tree").find_file(true)
	end
end

-- local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup({
	-- close_if_last_window = true,
	-- follow_current_file = true, -- This will find and focus the file in the active buffer every
	-- time the current file is changed while the tree is open.
	disable_netrw = true,
	hijack_netrw = true,
	-- open_on_setup = false,
	-- ignore_ft_on_setup = {},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	-- update_to_buf_dir = {
	-- 	enable = true,
	-- 	auto_open = true,
	-- },
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	view = {
		width = 25,
		-- hide_root_folder = false,
		side = "left",
		adaptive_size = true,
		-- mappings = {
			-- list = {
				-- { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				-- { key = "h", cb = tree_cb("close_node") },
				-- { key = "v", cb = tree_cb("vsplit") },
			-- },
		-- },
	},
})
return M

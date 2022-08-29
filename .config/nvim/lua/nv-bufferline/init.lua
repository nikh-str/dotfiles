local M = {}

M.config = function()
	-- Buffer line setup
	require("bufferline").setup({
		options = {
			indicator_icon = "▎",
			buffer_close_icon = "",
			modified_icon = "●",
			close_icon = "",
			close_command = "bdelete %d",
			right_mouse_command = "bdelete! %d",
			left_trunc_marker = "",
			right_trunc_marker = "",
			show_tab_indicators = true,
			show_close_icon = true,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
				},
			},
			-- separator_style = "thick",
		},
		highlights = {
			fill = {
				guifg = { attribute = "fg", highlight = "Normal" },
				guibg = { attribute = "bg", highlight = "Tabline" },
			},
			background = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
			},
			buffer_visible = {
				gui = "",
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
			},
			buffer_selected = {
				gui = "bold",
				guifg = { attribute = "fg", highlight = "BufSel" },
				guibg = { attribute = "bg", highlight = "BufSel" },
			},
			separator = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
			},
			separator_selected = {
				guifg = { attribute = "fg", highlight = "BufSep" },
				guibg = { attribute = "bg", highlight = "BufSel" },
			},
			separator_visible = {
				guifg = { attribute = "fg", highlight = "BufSep" },
				guibg = { attribute = "bg", highlight = "BufSep" },
			},
			close_button = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
			},
			close_button_selected = {
				guifg = { attribute = "fg", highlight = "BufferClose" },
				guibg = { attribute = "bg", highlight = "BufSel" },
			},
			close_button_visible = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
			},
			duplicate_selected = {
				guifg = { attribute = "fg", highlight = "BufSel" },
				guibg = { attribute = "bg", highlight = "BufSel" },
				gui = "italic",
			},
			duplicate_visible = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
				gui = "italic",
			},
			duplicate = {
				guifg = { attribute = "fg", highlight = "BufVis" },
				guibg = { attribute = "bg", highlight = "BufVis" },
				gui = "italic",
			},
		},
	})
end

return M

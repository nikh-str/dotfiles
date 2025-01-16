local M = {}

M.config = function()
	-- Buffer line setup
	require("bufferline").setup({
		options = {
			indicator = { style = "icon", icon = "▎" },
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
            color_icons = true,
            show_buffer_icons = true,
			-- separator_style = "thick",
		},
		highlights = {
			fill = {
				fg = { attribute = "fg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Tabline" },
			},
			background = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
			},
			buffer_visible = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
			},
			buffer_selected = {
				bold = true,
				fg = { attribute = "fg", highlight = "BufSel" },
				bg = { attribute = "bg", highlight = "BufSel" },
			},
			separator = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
			},
			separator_selected = {
				fg = { attribute = "fg", highlight = "BufSep" },
				bg = { attribute = "bg", highlight = "BufSel" },
			},
			separator_visible = {
				fg = { attribute = "fg", highlight = "BufSep" },
				bg = { attribute = "bg", highlight = "BufSep" },
			},
			close_button = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
			},
			close_button_selected = {
				fg = { attribute = "fg", highlight = "BufferClose" },
				bg = { attribute = "bg", highlight = "BufSel" },
			},
			close_button_visible = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
			},
			duplicate_selected = {
				fg = { attribute = "fg", highlight = "BufSel" },
				bg = { attribute = "bg", highlight = "BufSel" },
				italic = true,
			},
			duplicate_visible = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
				italic = true,
			},
			duplicate = {
				fg = { attribute = "fg", highlight = "BufVis" },
				bg = { attribute = "bg", highlight = "BufVis" },
				italic = true,
			},
		},
	})
end

return M

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local mouse = {
	LEFT = 1,
	MIDDLE = 2,
	RIGHT = 3,
	SCROLL_UP = 4,
	SCROLL_DOWN = 5,
}

-- Imports & Misc {{{
local C = require("misc.custom")
local B = require("ui.sidebar_bits")

function section_header(txt)
	return wibox.widget({
		C.force_left({
			widget = wibox.widget.textbox,
			markup = C.colorify(beautiful.xcolor6, string.upper(txt)),
			font = "Hack Nerd Font Bold 10",
		}),
		widget = wibox.container.margin,
		top = 12,
		bottom = 5,
	})
end
-- }}}

-- Layout {{{
local main_widget = wibox.widget({
	-- DATE & TIME {{{
	{
		section_header("DATE / TIME"),
		-- Clock {{{
		{
			C.force_center({
				{
					widget = wibox.widget.textclock,
					format = '<span font="Hack Nerd Font 20">%I:%M</span><span font="Hack Nerd Font 15">%p</span>',
				},
				widget = wibox.container.margin,
				margins = 10,
			}),
			widget = wibox.container.background,
			bg = "#32302f",
			-- bg = "#000000",
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, 12)
			end,
		},
		-- }}}
		{
			{
				-- DATE {{{
				{
					{
						C.force_center({
							widget = wibox.widget.textclock,
							format = "<span foreground='#000000' font='Hack Nerd Font 10'>  %a %d-%m-%y</span>",
						}),
						widget = wibox.container.margin,
						left = 8,
						top = 8,
						bottom = 8,
						right = 8,
					},
					bg = beautiful.xcolor4,
					widget = wibox.container.background,
					shape = gears.shape.rounded_bar,
				},
				-- }}}
				-- WEATHER {{{
				{
					{
						C.force_center(B.weather_widget),
						widget = wibox.container.margin,
						left = 8,
						top = 8,
						bottom = 8,
						right = 8,
					},
					bg = "#2E7B78",
					widget = wibox.container.background,
					shape = gears.shape.rounded_bar,
				},
				-- }}}
				spacing = 10,
				layout = wibox.layout.flex.horizontal,
			},
			top = 10,
			bottom = 10,
			widget = wibox.container.margin,
		},
		-- }}}
		-- MUSIC WIDGET {{{
		section_header("NOW PLAYING"),
		{
			B.music_image_widget,
			widget = wibox.container.constraint,
			height = 200,
			width = nil,
		},
		{
			-- Buttons {{{
			{
				{
					C.hover_effect({
						text = "玲",
						align = "right",
						font = "Hack Nerd Font",
						widget = wibox.widget.textbox,
						buttons = awful.button({}, mouse.LEFT, function()
							awful.spawn("playerctl previous")
						end),
					}, B.highlight_txt),
					B.play_pause,
					-- B.play_pause,
					C.hover_effect({
						text = "怜",
						font = "Hack Nerd Font",
						align = "left",
						widget = wibox.widget.textbox,
						buttons = awful.button({}, mouse.LEFT, function()
							awful.spawn("playerctl next")
						end),
					}, B.highlight_txt),
					layout = wibox.layout.flex.horizontal,
				},
				-- }}}
				widget = wibox.container.margin,
				left = 12,
				right = 12,
				top = 8,
				bottom = 8,
			},
			widget = wibox.container.background,
			bg = "#262222",
			shape = function(cr, w, h)
				gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 12)
			end,
		},
		-- }}}

		-- Hardware {{{
		{
			{
				C.force_left({
					widget = wibox.widget.textbox,
					markup = C.colorify(beautiful.xcolor6, string.upper("HARWARE")),
					font = "Hack Nerd Font Bold 10",
				}),
				C.force_right(C.hover_effect({
					widget = wibox.widget.textbox,
					font = "Hack Nerd Font Bold 13",
					markup = '<span color="#D79642"> </span>',
					buttons = awful.button({}, 1, function()
						awful.spawn.easy_async_with_shell(
							[[echo -en "Shutdown\0icon\x1fsystem-shutdown\nRestart\0icon\x1fsystem-restart\nLogout\0icon\x1fsystem-log-out\nLockscreen\0icon\x1fgnome-lockscreen\n" | rofi]],
							function(out)
								out = out:gsub("\n", "")
								if string.find(out, "Shutdown") then
									awful.spawn("systemctl poweroff")
								elseif string.find(out, "Restart") then
									awful.spawn("systemctl reboot")
								elseif string.find(out, "Logout") then
									awesome.quit()
								elseif string.find(out, "Lockscreen") then
									require("components.lockscreen").init()
									lock_screen_show()
								end
							end
						)
					end),
				}, B.highlight_txt)),
				layout = wibox.layout.flex.horizontal,
			},
			widget = wibox.container.margin,
			top = 10,
			bottom = 5,
		},
		{
			{
				-- TODO: Add meters using radial progress container
				B.ram_meter,
				B.cpu_meter,
				B.battery_meter,
				widget = wibox.layout.flex.vertical,
				spacing = 15,
			},
			-- {
			-- 	-- B.charge_indicator,
			-- 	B.temp_indicator,
			-- 	layout = wibox.layout.flex.vertical,
			-- 	spacing = 15,
			-- },
			B.hdd_meter,
			spacing = 20,
			layout = wibox.layout.fixed.horizontal,
		},
		-- }}}

		-- Todo {{{
		{
			{
				C.force_left({
					widget = wibox.widget.textbox,
					markup = C.colorify(beautiful.xcolor6, string.upper("TODO")),
					font = "Hack Nerd Font Bold 10",
				}),
				{
					nil,
					C.hover_effect({
						widget = wibox.widget.textbox,
						font = "Hack Nerd Font Bold 13",
						markup = '<span color="#45403d"> </span>',
						buttons = awful.button({}, 1, function()
							B.show_notifications()
						end),
					}, B.highlight_txt),
					C.hover_effect({
						widget = wibox.widget.textbox,
						font = "Arimo Nerd Font Bold 13",
						markup = '<span color="#45403d">樂</span>',
						buttons = awful.button({}, 1, function()
							awful.spawn.easy_async_with_shell("~/Documents/Scripts/todo.sh add-task-gui", function()
								B.update_tasklist()
							end)
						end),
					}, B.highlight_txt),
					layout = wibox.layout.align.horizontal,
					expand = "none",
				},
				layout = wibox.layout.flex.horizontal,
			},
			widget = wibox.container.margin,
			top = 10,
			bottom = 5,
		},
		B.todo_items,
		C.force_center(B.layout_box),
		layout = wibox.layout.fixed.vertical,
		-- }}}
	},
	widget = wibox.container.margin,
	left = 25,
	right = 25,
	top = 35,
	bottom = 35,
})

-- }}}
-- Window {{{

-- local main =
--     wibox(
--     {
--         -- type = "splash", -- change this if neccessary
--         width = 250,
--         visible = true,
--         bg = "#060606",
--         height = 1001,
--         screen = awful.screen.focused(),
--         widget = main_widget,
--         ontop = true,
--     }
-- )
-- awful.placement.right(main, {margins = {top = 1, right = 05}})

sidebar = wibox({
	width = 230,
	visible = false,
	bg = "#141313",
	height = 1040,
	ontop = true,
	shape = helpers.rrect(beautiful.notif_border_radius),
	type = "panel",
	widget = main_widget,
	screen = screen.primary,
})
awful.placement.left(sidebar, { margins = { top = 20, right = 0, bottom = -0 } })

sidebar_show = function()
	sidebar.visible = true
end

sidebar_hide = function()
	-- Do not hide it if prompt is active
	sidebar.visible = false
end

sidebar_toggle = function()
	if sidebar.visible then
		sidebar_hide()
	else
		sidebar.visible = true
	end
end

-- }}}

local gears = require("gears")
-- local lain = require("lain") --globally installed
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local bling = require("3rd-party.bling")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local markup = require("widget.util.markup")

local colorbar = {}

--{{{ bling task preview
bling.widget.task_preview.enable({
	x = 20, -- The x-coord of the popup
	y = 20, -- The y-coord of the popup
	height = 200, -- The height of the popup
	width = 200, -- The width of the popup
	placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
		awful.placement.top(c, {
			margins = {
				bottom = 30,
				top = 30,
			},
		})
	end,
	-- Your widget will automatically conform to the given size due to a constraint container.
	widget_structure = {
		{
			{
				{
					id = "icon_role",
					widget = awful.widget.clienticon, -- The client icon
				},
				{
					id = "name_role", -- The client name / title
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.flex.horizontal,
			},
			widget = wibox.container.margin,
			margins = 5,
		},
		{
			id = "image_role", -- The client preview
			resize = true,
			valign = "center",
			halign = "center",
			widget = wibox.widget.imagebox,
		},
		layout = wibox.layout.fixed.vertical,
	},
})
--}}}

--{{{ local wrap_widget
local wrap_widget = function(w)
	local wrapped = wibox.widget({
		w,
		top = dpi(5),
		left = dpi(4),
		bottom = dpi(5),
		right = dpi(4),
		widget = wibox.container.margin,
	})
	return wrapped
end
--}}}
--{{{ local make_pill
local make_pill = function(w)
	local pill = wibox.widget({
		w,
		bg = beautiful.bg_module,
		shape = helpers.rrect(11), -- radius
		widget = wibox.container.background,
	})
	return pill
end
--}}}

--{{{ Icon left -----------------------------------------------------------

local icon1 = wibox.widget({
	font = beautiful.icon_font_name .. "10.5" ,
	markup = "<span foreground='" .. beautiful.date_fg .. "'></span>",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	-- image = "",
	-- resize = true
})

local awesome_icon = wibox.widget({
	{
		icon1,
		buttons = {
			awful.button({}, 1, function()
				awful.spawn("sh -c '~/.local/bin/powermenu'")
			end),
		},
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(10),
		right = dpi(5),
		widget = wibox.container.margin,
	},
	bg = beautiful.bg_module,
	widget = wibox.container.background,
})

--}}}

--{{{ Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()
local keyboard_text = wibox.widget({
	font = beautiful.font,
	align = "center",
	valign = "center",
	widget = awful.widget.keyboardlayout(),
})

local keyboard_icon = wibox.widget({
	font = beautiful.icon_font_name .. "14",
	markup = "<span foreground='" .. beautiful.keyboard_fg .. "'> </span>",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local keyboard_pill = wibox.widget({
	{
		{ keyboard_icon, top = dpi(1), widget = wibox.container.margin },
		helpers.horizontal_pad(2),
		{ keyboard_text, top = dpi(1), widget = wibox.container.margin },
		layout = wibox.layout.fixed.horizontal,
	},
	left = dpi(4),
	right = dpi(4),
	widget = wibox.container.margin,
})

--}}}

--{{{ Net
local netdowninfo = wibox.widget.textbox()
local net = require("widget.net")
local netupinfo = net({
	settings = function()
		widget:set_markup(
			markup.fontfg(beautiful.font, beautiful.net_fg, markup.font(beautiful.numbers_font, net_now.sent) .. "kb ")
		)
		netdowninfo:set_markup(
			markup.fontfg(
				beautiful.font,
				beautiful.net_fg,
				beautiful.net_icon .. " " .. markup.font(beautiful.numbers_font, net_now.received) .. "kb "
			)
		)
	end,
})
--}}}

--{{{Stats pill (memory cpu battery, volume)

----- MEM-------------
local memicon = wibox.widget.textbox(markup.fontfg(beautiful.font, beautiful.memory_fg, beautiful.memory_icon .. " "))
local mem = require("widget.mem")
local memory = mem({
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, beautiful.memory_fg, mem_now.perc .. "% "))
	end,
})
-------- CPU--------------
local cpuicon = wibox.widget.textbox(markup.fontfg(beautiful.font, beautiful.cpu_fg, beautiful.cpu_icon .. " "))
local cpu_meter = require("widget.cpu")
local cpu = cpu_meter({
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, beautiful.cpu_fg, cpu_now.usage .. "% "))
	end,
})
--------Battery------------------------

local batteryWidget = require("widget.battery")

-- local battery_pill = wibox.widget({
-- 	{
-- 		{ batteryWidget(beautiful.power_fg), top = dpi(0), widget = wibox.container.margin },
-- 		helpers.horizontal_pad(1),
-- 		layout = wibox.layout.fixed.horizontal,
-- 	},
-- 	-- buttons = {
-- 	-- awful.button({ }, 1, function () awful.spawn( "alacritty  -e calcurse") end),
-- 	-- },
-- 	left = dpi(5),
-- 	right = dpi(5),
-- 	widget = wibox.container.margin,
-- })

-- ALSA volume
local alsa = require("widget.alsa")
beautiful.volume = alsa({
	settings = function()
		if volume_now.status == "off" then
			volume_now.level = volume_now.level
			beautiful.volume_icon = "婢"
		else
			beautiful.volume_icon = ""
		end

		widget:set_markup(
			markup.fontfg(beautiful.font, beautiful.volume_fg, beautiful.volume_icon .. " " .. volume_now.level .. "% ")
		)
	end,
})

local stats_pill = wibox.widget({
	{
		{ batteryWidget(beautiful.power_fg), top = dpi(1), right = dpi(5), widget = wibox.container.margin },

		{
			cpuicon,
			top = dpi(1),
			widget = wibox.container.margin,
			buttons = {
				awful.button({}, 1, function()
					awful.spawn("alacritty  -e gotop")
				end),
			},
		},

		helpers.horizontal_pad(2),

		{ cpu, top = dpi(1), widget = wibox.container.margin },
		{ memicon, top = dpi(1), widget = wibox.container.margin },
		{ memory, top = dpi(1), widget = wibox.container.margin },
		{
			beautiful.volume.widget,
			top = dpi(1),
			left = dpi(5),
			widget = wibox.container.margin,
			buttons = {
				awful.button({}, 1, function()
					awful.spawn("alacritty --title volume -e alsamixer")
				end),
			},
		},
		layout = wibox.layout.fixed.horizontal,
	},

	left = dpi(7),
	right = dpi(7),
	widget = wibox.container.margin,
})
--}}}

--{{{Updates widget
-- local scripts_beg = "bash -c '~/.local/bin/'"
local updates_icon =
	wibox.widget.textbox(markup.fontfg(beautiful.font, beautiful.updates_fg, beautiful.updates_icon .. "  "))
-- local updates = awful.widget.watch(string.format("%s/updates.sh", scripts_beg), 600)
-- function (widget, stdout)
-- widget:set_markup(markup.fontfg(theme.numbers_font, theme.updates_fg, stdout))
-- end)

-- local updates2 = awful.widget.watch(' bash -c "updates.sh"' , 600)
local updates_text = wibox.widget({
	font = beautiful.font,
	align = "left",
	valign = "center",
	-- widget = awful.widget.watch(' bash -c "/home/niki/.local/bin/updates.sh"' , 600)
	widget = awful.widget.watch(' bash -c "checkupdates 2>/dev/null | wc -l"', 120),
})

local updates_pill = wibox.widget({
	{
		{ updates_icon, top = dpi(1), widget = wibox.container.margin },
		helpers.horizontal_pad(2),
		{ updates_text, top = dpi(1), left = dpi(-2), right = dpi(3), widget = wibox.container.margin },
		layout = wibox.layout.fixed.horizontal,
	},
	left = dpi(7),
	right = dpi(7),
	widget = wibox.container.margin,
})
--}}}

--{{{DateTime Widget -----------------------------

---------------------- Date Widget ------------------------
local date_text = wibox.widget({
	font = beautiful.font,
	format = "%d/%m",
	align = "center",
	valign = "center",
	widget = wibox.widget.textclock,
})

date_text.markup = "<span foreground='" .. beautiful.date_fg .. "'>" .. date_text.text .. "</span>"

date_text:connect_signal("widget::redraw_needed", function()
	date_text.markup = "<span foreground='" .. beautiful.date_fg .. "'>" .. date_text.text .. "</span>"
end)

local date_icon = wibox.widget({
	font = beautiful.icon_font_name .. "8",
	markup = "<span foreground='" .. beautiful.date_fg .. "'></span>",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

---------------------- Time Widget ------------------------

local time_text = wibox.widget({
	font = beautiful.font,
	format = "%l:%M %P",
	align = "center",
	valign = "center",
	widget = wibox.widget.textclock,
})

time_text.markup = "<span foreground='" .. beautiful.time_fg .. "'>" .. time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
	time_text.markup = "<span foreground='" .. beautiful.time_fg .. "'>" .. time_text.text .. "</span>"
end)

local time_icon = wibox.widget({
	font = beautiful.icon_font_name .. "9",
	markup = "<span foreground='" .. beautiful.time_fg .. "'> </span>",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})
local datetime_pill = wibox.widget({
	{
		{ date_icon, top = dpi(1), widget = wibox.container.margin },
		helpers.horizontal_pad(7),
		{ date_text, top = dpi(1), widget = wibox.container.margin },
		{ time_icon, top = dpi(1), widget = wibox.container.margin },
		helpers.horizontal_pad(1),
		{ time_text, top = dpi(1), widget = wibox.container.margin },
		layout = wibox.layout.fixed.horizontal,
	},
	buttons = {
		awful.button({}, 1, function()
			awful.spawn("alacritty --title calendar -e calcurse")
		end),
	},
	left = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin,
}) --------------------------------------
--}}}

--{{{MPD-------------------------------------------
local mpdarc_widget = require("3rd-party.awesome-wm-widgets.mpdarc-widget.mpdarc")

local mpd_pill = wibox.widget({
	{
		{ mpdarc_widget, top = dpi(2), bottom=dpi(2), widget = wibox.container.margin },
		helpers.horizontal_pad(3),
		layout = wibox.layout.fixed.horizontal,
	},
	-- buttons = {
	-- awful.button({ }, 1, function () awful.spawn( "alacritty --title music -e /home/niki/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug") end),
	-- },
	left = dpi(5),
	right = dpi(2),
	widget = wibox.container.margin,
})

-- local mpdicon = wibox.widget.imagebox()
-- local mpdicon = wibox.widget.textbox(markup.fontfg(theme.font, theme.mpd_fg, theme.mpd_icon .. " "))
-- theme.mpd = lain.widget.mpd({
--     settings = function()
--         mpd_notification_preset = {
--             text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
--                    mpd_now.album, mpd_now.date, mpd_now.title)
--         }

--         if mpd_now.state == "play" then
--             artist = "  " .. mpd_now.artist .. " > "
--             title  = mpd_now.title .. " "
--         elseif mpd_now.state == "pause" then
--             artist = " 契"
--             title  = " Paused "
--         else
--             artist = ""
--             title  = ""
--             --mpdicon:set_image() -- not working in 4.0
--             mpdicon._private.image = nil
--             mpdicon:emit_signal("widget::redraw_needed")
--             mpdicon:emit_signal("widget::layout_changed")
--         end
--         widget:set_markup(markup.fontfg(theme.font, theme.artist_fg, artist) .. markup.fontfg(theme.font, "#A97D3A", title))
--     end
-- })
--}}}

--{{{  Tasklist Buttons ---------------------------------------------------

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)
--}}}

--{{{Systray---------------------------------
local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)
local mysystray_container = {
	mysystray,
	left = dpi(8),
	right = dpi(8),
	widget = wibox.container.margin,
}

local final_systray = wibox.widget({
	{
		mysystray_container,
		top = dpi(1),
		botttom = dpi(1),
		left = dpi(1),
		right = dpi(1),
		layout = wibox.container.margin,
	},
	bg = beautiful.bg_module,
	shape = helpers.rrect(10),
	widget = wibox.container.background,
})
---}}}

function beautiful.at_screen_connect(s, monitor)
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			shape_border_width = 0,
			shape_border_color = beautiful.xcolor1,
			shape = gears.shape.rounded_bar,
		},
		layout = {
			spacing = 8,
			spacing_widget = {
				{
					-- forced_width = 10,
					color = "#27242405",
					-- shape        = gears.shape.circle,
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
						forced_width = 5,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 5,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,

			create_callback = function(self, c) --luacheck: no unused args
				self:get_children_by_id("icon_role")[1].client = c
				-- BLING: Toggle the popup on hover and disable it off hover
				self:connect_signal("mouse::enter", function()
					awesome.emit_signal("bling::task_preview::visibility", s, true, c)
				end)
				self:connect_signal("mouse::leave", function()
					awesome.emit_signal("bling::task_preview::visibility", s, false, c)
				end)
			end,
		},
	})
	---}}}

	--{{{Layout Box--------------------------------------------------------
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end)
	))
	---}}}

	--{{{Tags---------------------------------
	-- awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
	-- Create a taglist widget
	-- s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	local modkey = "Mod4"
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			-- awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
			-- awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
		},
	})
	-- Create the taglist widget
	-- s.mytaglist = require("ui.widgets.pacman_taglist")(s)
	---}}}

	-- Create the wibox
	s.mywibox = awful.wibar({
		beautiful.bar_position,
		screen = s,
		beautiful.bar_height,
		bg = beautiful.bg,
		fg = beautiful.fg_normal,
		beautiful.opacity,
	})

	--{{{ wibox-setup
	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.vertical,
		nil,
		{
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{
					layout = wibox.layout.fixed.horizontal,
					helpers.horizontal_pad(4),
					-- function to add padding
					wrap_widget( --
						-- function to add pill
						make_pill({
							awesome_icon,
							{
								s.mytaglist,
								helpers.horizontal_pad(6),
								layout = wibox.layout.fixed.horizontal,
								bottom = dpi(4),
								top = dpi(4),
							},
							spacing = 10,
							spacing_widget = {
								color = beautiful.xcolor8,
								shape = gears.shape.powerline,
								widget = wibox.widget.separator,
							},
							layout = wibox.layout.fixed.horizontal,
						})
					),
					-- s.mypromptbox,
					wrap_widget(make_pill(mpd_pill)),
				},
				{ wrap_widget(s.mytasklist), widget = wibox.container.constraint },
				{
					wrap_widget(make_pill({ updates_pill, left = dpi(8), widget = wibox.container.margin })),
					-- wrap_widget(make_pill(battery_pill)),
					-- netdowninfo,
					-- netupinfo.widget,
					wrap_widget(make_pill(keyboard_pill)),
					wrap_widget(make_pill(stats_pill)),
					-- wrap_widget(make_pill({
					-- 	beautiful.volume.widget,
					-- 	left = dpi(8),
					-- 	widget = wibox.container.margin,
					-- 	buttons = {
					-- 		awful.button({}, 1, function()
					-- 			awful.spawn("alacritty --title volume -e alsamixer")
					-- 		end),
					-- 	},
					-- })),
					wrap_widget(make_pill({
						datetime_pill,
						left = dpi(8),
						right = dpi(8),
						top = dpi(4),
						bottom = dpi(4),
						widget = wibox.container.margin,
					})),
					wrap_widget(make_pill({
						s.mylayoutbox,
						top = dpi(2),
						bottom = dpi(2),
						right = dpi(8),
						left = dpi(8),
						widget = wibox.container.margin,
					})),
					wrap_widget(make_pill({
						final_systray,
						top = dpi(2),
						bottom = dpi(2),
						left = dpi(8),
						right = dpi(8),
						widget = wibox.container.margin,
					})),
					helpers.horizontal_pad(9),
					layout = wibox.layout.fixed.horizontal,
				},
			},
			widget = wibox.container.background,
			bg = beautiful.wibar_bg_secondary,
		},
		{ -- This is for a bottom border in the bar
			widget = wibox.container.background,
			-- bg = beautiful.wibar_border_color,
			forced_height = beautiful.widget_border_width,
		},
	})
	---}}}
end

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
end)

return colorbar

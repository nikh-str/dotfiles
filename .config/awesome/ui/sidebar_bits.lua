local bling = require("3rd-party.bling")
local gears = require("gears")
local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
-- local beautiful = require("beautiful")
local wibox = require("wibox")
local C = require("misc.custom")

local M = {}
local user_home = "/home/niqi"
local mouse = {
	LEFT = 1,
	MIDDLE = 2,
	RIGHT = 3,
	SCROLL_UP = 4,
	SCROLL_DOWN = 5,
}
M.highlight_txt = function(w, m)
	if m then
		w.original_markup = w.markup or w.text
		w.markup = require("misc.custom").colorify("#fafafa", w.text)
	else
		w.markup = w.original_markup
	end
end

-- {{{ WEATHER WIDGET
-- CHANGE
local city = "Amsterdam"

M.weather_widget = wibox.widget({
	widget = wibox.widget.textbox,
	text = "Strange",
	font = "Hack Nerd Font Italic 10",
})

awful.spawn.easy_async("curl -s 'wttr.in/" .. city .. "?format=%c+%f'", function(out, _, _, _)
	if string.len(out) > 0 then
		out = out:gsub("  ", " ")
		out = out:gsub("\n", "")
		M.weather_widget.markup = C.colorify("#32302f", out)
	end
end)

-- }}}
--- {{{ MUSIC WIDGET

playerctl_state = {
	image = user_home .. "/.config/awesome/theme/record.jpg",
	playing = "Nothing Playing.",
	_playing = "契",
	cover = "/tmp/mpd_cover.jpg",
}
M.play_pause = C.hover_effect({
	widget = wibox.widget.textbox,
	text = "契",
	align = "center",
	font = "Hack Nerd Font",
	buttons = awful.button({}, mouse.LEFT, function()
		awful.spawn("playerctl play-pause")
	end),
}, M.highlight_txt)

M.music_image_widget = wibox.widget({
	widget = wibox.widget.imagebox,
	resize = true,
	image = gears.surface.load_uncached(playerctl_state.image),
	clip_shape = function(cr, w, h)
		gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 8)
	end,
})

M.music_image_widget:buttons(awful.button({}, mouse.MIDDLE, function()
	M.music_image_widget:set_image(gears.surface.load_uncached(user_home .. "/.config/awesome/theme/record.jpg"))
	playerctl_state.image = user_home .. "/.config/awesome/theme/record.jpg"
end))

local music_title_tooltip = awful.tooltip({
	objects = { M.music_image_widget },
	text = playerctl_state.playing,
	bg = "#32302f",
	fg = "#d4be98",
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 3)
	end,
})

-- cover_art = awful.spawn.easy_async( "ffmpeg -y -i "$(mpc \\-\\-format "$music_library"/%file% | head -n 1)" /tmp/mpd_cover.jpg > /dev/null 2>&1 && "
-- function(out,_,_,_)
--     M.music_image_widget:set_image(gears.surface.load_uncached(out))
-- end
-- )

bling.signal.playerctl.lib()
awesome.connect_signal("bling::playerctl::title_artist_album", function(title, artist, art_path)
	music_title_tooltip.text = title .. " ~ " .. artist
	M.music_image_widget:set_image(gears.surface.load_uncached(art_path))
	-- Update state
	playerctl_state.playing = title .. " ~ " .. artist
	playerctl_state.image = art_path
end)

awesome.connect_signal("bling::playerctl::status", function(x)
	if x then
		M.play_pause.text = ""
		playerctl_state._playing = ""
	else
		M.play_pause.text = "契"
		playerctl_state._playing = "契"
	end
end)

-- show volume-adjust when "mpd_change" signal is emitted
awesome.connect_signal("signal::mpd", function(album_art, title)
	M.music_image_widget:set_image(gears.surface.load_uncached("/tmp/mpd_cover.jpg"))
	playerctl_state.image = album_art
end)

-- }}}
--{{{ TODO WIDGET

M.todo_items = wibox.widget({
	widget = wibox.widget.textbox,
	text = "Strange",
	font = "Hack Nerd Font Italic 11",
})

-- awful.spawn.easy_async(
awful.widget.watch('bash -c "calcurse -Q"', 600, function(widget, out)
	M.todo_items.markup = C.colorify("#C79761", out)
end)

-- M.layout_box = awful.widget.layoutbox()
-- M.layout_box.forced_width = dpi(25)
-- M.layout_box.forced_height = dpi(25)

-- }}}
--]]
-- -Hardware_meters
-- RAM Meter {{{

M.ram_meter = wibox.widget({
	{
		widget = wibox.widget.textbox,
		text = "RAM",
		align = "center",
		forced_width = dpi(60),
		forced_height = dpi(60),
	},
	border_color = "#45403d",
	max_value = 100, -- DONT CHANGE
	min_value = 0,
	border_width = dpi(6),
	color = "#a9b665",
	widget = wibox.container.radialprogressbar,
})

local ram_tooltip = awful.tooltip({
	objects = { M.ram_meter },
	text = "",
	bg = "#32302f",
	fg = "#d4be98",
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 3)
	end,
})

awesome.connect_signal("system::ram", function(used, total)
	M.ram_meter:set_value(math.ceil((used / total) * 100))
	ram_tooltip:set_text(used .. " / " .. total .. " mb")
end)

-- }}}
-- CPU Meter {{{

M.cpu_meter = wibox.widget({
	{
		widget = wibox.widget.textbox,
		text = "CPU",
		align = "center",
		forced_width = dpi(60),
		forced_height = dpi(60),
	},
	border_color = "#45403d",
	max_value = 100, -- DONT CHANGE
	min_value = 0,
	border_width = dpi(6),
	color = "#7daea3",
	widget = wibox.container.radialprogressbar,
})

local cpu_tooltip = awful.tooltip({
	objects = { M.cpu_meter },
	text = "",
	bg = "#32302f",
	fg = "#d4be98",
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 3)
	end,
})

awesome.connect_signal("system::cpu", function(percentage)
	M.cpu_meter:set_value(percentage)
	cpu_tooltip:set_text(percentage .. "%")
end)

-- }}}
-- Hardrive Meter {{{

M.hdd_meter = wibox.widget({
	{
		{
			widget = wibox.widget.progressbar,
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, 8)
			end,
			max_value = 100,
			min_value = 1,
			id = "bar",
			color = "#d3869b",
			background_color = "#2D2C2C", -- "#1d2021"
		},
		{ widget = wibox.widget.textbox, text = "HDD", align = "center" },
		layout = wibox.layout.stack,
	},
	widget = wibox.container.rotate,
	forced_height = 100,
	forced_width = 40,
	direction = "east",
})

local hdd_tooltip = awful.tooltip({
	objects = { M.hdd_meter },
	text = "",
	bg = "#32302f",
	fg = "#d4be98",
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 3)
	end,
})

awesome.connect_signal("system::disk", function(used, total)
	M.hdd_meter:get_children_by_id("bar")[1]:set_value(math.ceil((used / total) * 100))
	hdd_tooltip:set_text(used .. "/" .. total .. " GB")
end)

-- }}}
-- BATTERY / WIFI INDICATOR {{{

M.charge_indicator = wibox.widget({
	widget = wibox.widget.textbox,
	text = "ﮣ",
	font = "Hack Nerd Font 20",
})

local battery_icons = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
awesome.connect_signal("system::battery", function(percentage)
	local index = math.min(math.ceil(percentage / 10) * 10, 100) / 10
	M.charge_indicator:set_text(battery_icons[index])
end)

M.battery_meter = wibox.widget({
	{
		widget = wibox.widget.textbox,
		text = "BAT",
		align = "center",
		forced_width = dpi(60),
		forced_height = dpi(60),
	},
	border_color = "#45403d",
	max_value = 100, -- DONT CHANGE
	min_value = 0,
	border_width = dpi(6),
	color = "#C5A628",
	widget = wibox.container.radialprogressbar,
})

local battery_tooltip = awful.tooltip({
	objects = { M.battery_meter },
	text = "",
	bg = "#32302f",
	fg = "#d4be98",
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 3)
	end,
})

awesome.connect_signal("system::battery", function(percentage)
	M.battery_meter:set_value(percentage)
	battery_tooltip:set_text(percentage .. "%")
end)

M.temp_indicator = wibox.widget({
	widget = wibox.widget.textbox,
	text = "??",
	font = "Hack Nerd Font",
})

-- }}}
-- Temperature Indicator {{{
--
--local temp_tooltip =
--    awful.tooltip {
--    objects = {M.temp_indicator},
--    text = "",
--    bg = "#32302f",
--    fg = "#d4be98",
--    shape = function(cr, w, h)
--        gears.shape.rounded_rect(cr, w, h, 3)
--    end
--}
--
----              20    40    60    80    100
--local temp_icons = {" ", " ", " ", " ", " "}
--
--awesome.connect_signal(
--    "system::temp",
--    function(avgTemp)
--        temp_tooltip:set_text(avgTemp .. "°C")
--        local icon = ""
--
--        if avgTemp <= 20 then
--            icon = temp_icons[1]
--        elseif avgTemp <= 40 then
--            icon = temp_icons[2]
--        elseif avgTemp <= 60 then
--            icon = temp_icons[3]
--        elseif avgTemp <= 80 then
--            icon = temp_icons[4]
--        else
--            icon = temp_icons[5]
--        end
--
--        M.temp_indicator:set_text(icon)
--    end
--)
--
-- }}}

-- return gears.table.join(M, require("subcomponents.hardware_meters"))
return M

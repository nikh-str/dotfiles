-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local revelation = require("3rd-party.revelation")
revelation.init()

local awesome, client = awesome, client

-- Bling bling
local bling = require("3rd-party.bling")
local switcher = require("3rd-party.awesome-switcher")

-- Global Vars
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

local modkey = "Mod4"
-- local altgrkey = "Mod5"

local terminal = "alacritty"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor

-- {{{ Global Key bindings
-- globalkeys = gears.table.join(
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	awful.key({ modkey }, "Tab", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ "Mod1" }, "Escape", revelation, { description = "preview all windows", group = "client" }),

	awful.key({ "Mod1" }, "Tab", function()
		awesome.emit_signal("bling::window_switcher::turn_on")
	end, { description = "Window Switcher", group = "bling" }),

	-- 	awful.key({ "Mod1" }, "Tab", function()
	-- 		switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
	-- 	end),

	-- 	awful.key({ "Mod1", "Shift" }, "Tab", function()
	-- 		switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
	-- 	end),

	--{{{----Tabs-------------------------
	awful.key({ "Mod1" }, "a", function()
		bling.module.tabbed.pick_with_dmenu()
	end, {
		description = "pick client to add to tab group",
		group = "tabs",
	}),

	awful.key({ "Mod1" }, "s", function()
		bling.module.tabbed.iter()
	end, { description = "iterate through tabbing group", group = "tabs" }),

	awful.key({ "Mod1" }, "r", function()
		bling.module.tabbed.pop()
	end, {
		description = "remove focused client from tabbing group",
		group = "tabs",
	}),

	awful.key({ modkey, "Shift" }, "t", function()
		bling.module.tabbed.pick()
	end, { description = "Add tab to tabbing group", group = "tabs" }),
	-- }}}

	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),

	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	awful.key(
		{ modkey, "Shift" },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),

	-- awful.key({ modkey }, "Tab", function()
	-- 	awful.client.focus.history.previous()
	-- 	if client.focus then
	-- 		client.focus:raise()
	-- 	end
	-- end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey, "Control" }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "b", function()
		myscreen = awful.screen.focused()
		myscreen.mywibox.visible = not myscreen.mywibox.visible
	end, { description = "toggle statusbar" }),
	awful.key({ "Mod1" }, ",", function()
		sidebar_toggle()
	end, { description = "show or hide sidebar", group = "awesome" }),

	-- Layout manipulation

	--{{{--------Set layouts--------------------------------
	awful.key({ modkey }, "s", function()
		awful.layout.set(awful.layout.suit.tile)
	end, { description = "set tile layout", group = "tag" }),
	awful.key({ modkey, "Shift" }, "s", function()
		awful.layout.set(awful.layout.suit.floating)
	end, { description = "set floating layout", group = "tag" }),
	awful.key({ modkey }, "c", function()
		awful.layout.set(bling.layout.mstab)
	end, { description = "set mstab layout", group = "tag" }),
	---}}}

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),

	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ "Mod1" }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ "Mod1" }, "u", function()
		awesome.emit_signal("scratch::term_scratch")
	end, { description = "open term scrathchpad", group = "scratchpad" }),

	awful.key({ "Mod1" }, "l", function()
		awesome.emit_signal("scratch::tex_scratch")
	end, { description = "open tex scrathchpad", group = "scratchpad" }),

	awful.key({ "Mod1" }, "m", function()
		awesome.emit_signal("scratch::music_scratch")
	end, { description = "open music scrathchpad", group = "scratchpad" }),

	awful.key({ "Mod1" }, ".", function()
		awesome.emit_signal("scratch::calendar_scratch")
	end, { description = "open calendar scrathchpad", group = "scratchpad" }),

	awful.key({ "Mod1" }, "/", function()
		awesome.emit_signal("scratch::ranger_scratch")
	end, { description = "open ranger scrathchpad", group = "scratchpad" }),

	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioPause", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioStop", function()
		awful.util.spawn("playerctl stop", false)
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false)
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false)
	end),

	-- Prompt
	awful.key({ modkey }, "d", function()
		awful.util.spawn("dmenu_run")
	end, { description = "run dmenu", group = "launcher" }),
})
---}}}

--{{{Client Keys

clientkeys = gears.table.join(

	-- working toggle titlebar
	awful.key({ modkey, "Control" }, "t", function(c)
		awful.titlebar.toggle(client.focus, "left")
	end, { description = "Show/Hide Titlebars", group = "client" }),

	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	-- Change client opacity

	awful.key({ "Control", modkey }, "o", function(c)
		c.opacity = c.opacity - 0.1
	end, { description = "decrease client opacity", group = "client" }),
	awful.key({ modkey, "Shift" }, "o", function(c)
		c.opacity = c.opacity + 0.1
	end, { description = "increase client opacity", group = "client" }),

	awful.key({ modkey }, "w", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),

	awful.key({ modkey }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),

	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),

	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),

	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" }),

	--{{{ On the fly useless gaps change
	awful.key({ modkey }, "=", function()
		helpers.resize_gaps(5)
	end, { description = "add gaps", group = "screen" }),

	awful.key({ modkey }, "-", function()
		helpers.resize_gaps(-5)
	end, { description = "subtract gaps", group = "screen" }),
	-- Single tap: Center client
	-- Double tap: Center client + Floating + Resize

	awful.key({ modkey }, ".", function(c)
		awful.placement.centered(c, {
			honor_workarea = true,
			honor_padding = true,
		})
		helpers.single_double_tap(nil, function()
			helpers.float_and_resize(c, screen_width * 0.25, screen_height * 0.28)
		end)
	end)
	--}}}
)
---}}}

--{{{Tags keys
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),

		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),

		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),

		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

-- Numpad: [0-9] = [#90, #87-#89, #83-#85, #79-#81]
local np_map = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }
for i = 1, 9 do
	globalkeys = awful.util.table.join(
		globalkeys,
		awful.key({ modkey }, "#" .. np_map[i], function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end),

		awful.key({ modkey, "Control" }, "#" .. np_map[i], function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end),

		awful.key({ modkey, "Shift" }, "#" .. np_map[i], function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end)
	)
end

--}}}

---{{{Mouse Bindings
clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)
---}}}

-- Set keys
root.keys(globalkeys)

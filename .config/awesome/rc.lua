--
--
-- ▄▄▄       █     █░▓█████   ██████  ▒█████   ███▄ ▄███▓▓█████
-- ▒████▄    ▓█░ █ ░█░▓█   ▀ ▒██    ▒ ▒██▒  ██▒▓██▒▀█▀ ██▒▓█   ▀
-- ▒██  ▀█▄  ▒█░ █ ░█ ▒███   ░ ▓██▄   ▒██░  ██▒▓██    ▓██░▒███
-- ░██▄▄▄▄██ ░█░ █ ░█ ▒▓█  ▄   ▒   ██▒▒██   ██░▒██    ▒██ ▒▓█  ▄
--  ▓█   ▓██▒░░██▒██▓ ░▒████▒▒██████▒▒░ ████▓▒░▒██▒   ░██▒░▒████▒
--  ▒▒   ▓▒█░░ ▓░▒ ▒  ░░ ▒░ ░▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░   ░  ░░░ ▒░ ░
--   ▒   ▒▒ ░  ▒ ░ ░   ░ ░  ░░ ░▒  ░ ░  ░ ▒ ▒░ ░  ░      ░ ░ ░  ░
--   ░   ▒     ░   ░     ░   ░  ░  ░  ░ ░ ░ ▒  ░      ░      ░
--       ░  ░    ░       ░  ░      ░      ░ ░         ░      ░  ░
--
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("config.errorhandling")

-- choose your theme here
local chosen_theme = "multicolor"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)


require("config")

-- Screen Padding and Tags
screen.connect_signal("request::desktop_decoration", function(s)
--- Each screen has its own tag table.
awful.tag({"", "", "", "", "龎", ""}, s, awful.layout.layouts[1])
end)

require("signal")
require("ui")

local counter = 0
for s in screen do
    if counter == 0 then
        beautiful.at_screen_connect(s, counter)
    else
        beautiful.at_screen_connect(s, counter)
    end
    counter = counter + 1
end


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup
       then
          awful.client.setslave(c)
       end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

 ---{{{--Autostart apps
-- awful.spawn.with_shell("~/.config/awesome/autostart.sh")
 local function run_once(cmd)
     local findme = cmd
     local firstspace = cmd:find(" ")
     if firstspace then findme = cmd:sub(0, firstspace - 1) end
     awful.spawn.easy_async_with_shell(string.format(
                                           "pgrep -u $USER -x %s > /dev/null || (%s)",
                                           findme, cmd))
                                       end
 -- LuaFormatter off
 -- Add apps to autostart here
 autostart_apps = {
     -- Disable Bell
     "wal -R -s &"
 }
 -- LuaFormatter on

 for app = 1, #autostart_apps do run_once(autostart_apps[app]) end

 -- EOF ------------------------------------------------------------------------
 ---}}}

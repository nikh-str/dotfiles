local awful = require("awful")
local gears = require("gears")
local gfs = gears.filesystem
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local bling = require("module.bling")

 
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
-- browser = "firefox"
-- filemanager = "thunar"
-- launcher = "rofi -show drun"
music = terminal .. " start --class music ncmpcpp"
modkey= "Mod4"

-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height


-- bling.signal.playerctl.enable {
--     ignore = {"firefox", "chromium"},
--     backend = "playerctl_lib",
--     update_on_activity = true
-- }

bling.widget.tag_preview.enable {
    show_client_content = false,
    x = dpi(10),
    y = dpi(10) + beautiful.wibar_height,
    scale = 0.15,
    honor_padding = true,
    honor_workarea = false
}
require("config.keys")
require("config.layout")
require("config.ruled")
require("config.rules")

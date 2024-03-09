--[[
     Multicolor Awesome WM theme 2.0
     github.com/lcpz
--]]

-- local awful = require("awful")
-- local wibox = require("wibox")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
-- local gears = require("gears")
-- local gfs = require("gears.filesystem")
-- local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")
local os = os

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/theme/multicolor"
--Fonts
theme.font_name = "mononoki Nerd Font Bold "
theme.font = theme.font_name .. "10"
theme.icon_font_name = "Iosevka Nerd Font "
theme.icon_font = theme.icon_font_name .. "14"
theme.taglist_font = "Iosevka Nerd Font 16"
theme.numbers_font = "Hack Nerd Font Bold 11"
--Icons
theme.updates_icon = ""
theme.textclock_icon = "  "
theme.time_icon = " "
theme.memory_icon = ""
theme.volume_icon = ""
theme.netdown_icon = ""
theme.net_icon = " "
theme.gputemp_icon = ""
theme.cpu_icon = ""
theme.power_icon = ""
theme.mpd_icon = ""
--Colors
--Widget colors
theme.separator_fg = "#332F2F"
theme.updates_fg = "#C03D1E"
theme.artist_fg = "#af3a1f"
theme.textclock_fg = "#218092"
theme.keyboard_fg = "#BD971C"
theme.date_fg = "#59ACAF"
theme.time_fg = "#C94628"
theme.memory_fg = "#b16286"
theme.volume_fg = "#9F7DCF"
theme.net_fg = "#83c07c"
theme.cpu_fg = "#348B71"
theme.power_fg = "#ff6c6b"
theme.mpd_fg = "#30117D"
theme.gray = "#4B4A4F"
--Other colors
theme.menu_bg_normal = "#000000"
theme.menu_bg_focus = "#000000"
theme.bg_normal = "#090808"
theme.bg_focus = "#000000"

theme.fg_occupied = "#54C8BF"
theme.bg_urgent = "#000000"
theme.fg_normal = "#977365"
theme.fg_focus = "#ff8c00"
theme.fg_dark = "#cccccc"
theme.fg_urgent = "#af1d18"
theme.fg_minimize = "#54C8BF"
theme.bg_minimize = "#38837B"
theme.menu_border_width = 0
theme.menu_width = 140
theme.menu_submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal = "#aaaaaa"
theme.menu_fg_focus = "#ff8c00"
theme.menu_bg_normal = "#050505dd"
theme.menu_bg_focus = "#050505dd"
theme.useless_gap = 5
theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"
theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/dwindle.png"
theme.layout_max = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal = theme.confdir .. "/icons/titlebar/close_normal.svg"
theme.titlebar_close_button_focus = theme.confdir .. "/icons/titlebar/close_focus.svg"
theme.titlebar_close_button_focus_hover = theme.confdir .. "/icons/titlebar/close_focus_hover.svg"
-- minimize
theme.titlebar_minimize_button_normal = theme.confdir .. "/icons/titlebar/minimize_normal.svg"
theme.titlebar_minimize_button_focus = theme.confdir .. "/icons/titlebar/minimize_focus.svg"
theme.titlebar_minimize_button_focus_hover = theme.confdir .. "/icons/titlebar/minimize_focus_hover.svg"
-- ontop
theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
-- sticky
theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
-- floating
theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
-- maximized
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = theme.confdir .. "/icons/titlebar/maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active = theme.confdir .. "/icons/titlebar/maximized_focus_active.svg"
theme.titlebar_maximized_button_focus_active_hover = theme.confdir .. "/icons/titlebar/maximized_focus_active_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = theme.confdir
	.. "/icons/titlebar/maximized_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = theme.confdir
	.. "/icons/titlebar/maximized_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = theme.confdir
	.. "/icons/titlebar/maximized_focus_active_hover.svg"

theme.titlebar_size = dpi(34)

-- -- Icons for Notif Center
-- local icon_path = theme.confdir .. "icons/"

-- theme.clear_icon = icon_path .. "notif-center/clear.png"
-- theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.notification_icon = theme.confdir .. "/icons/notification.png"
-- theme.delete_icon = icon_path .. "notif-center/delete.png"
-- theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

-- local markup = lain.util.markup

-- Load ~/.Xresources colors and set fallback colors
--
theme.xbackground = xrdb.background or "#1a2026"
theme.xforeground = xrdb.foreground or "#ffffff"
theme.xcolor0 = xrdb.color0 or "#29343d"
theme.xcolor1 = xrdb.color1 or "#f9929b"
theme.xcolor2 = xrdb.color2 or "#7ed491"
theme.xcolor3 = xrdb.color3 or "#fbdf90"
theme.xcolor4 = xrdb.color4 or "#a3b8ef"
theme.xcolor5 = xrdb.color5 or "#ccaced"
theme.xcolor6 = xrdb.color6 or "#9ce5c0"
theme.xcolor7 = xrdb.color7 or "#ffffff"
theme.xcolor8 = xrdb.color8 or "#3b4b58"
theme.xcolor9 = xrdb.color9 or "#fca2aa"
theme.xcolor10 = xrdb.color10 or "#a5d4af"
theme.xcolor11 = xrdb.color11 or "#fbeab9"
theme.xcolor12 = xrdb.color12 or "#bac8ef"
theme.xcolor13 = xrdb.color13 or "#d7c1ed"
theme.xcolor14 = xrdb.color14 or "#c7e5d6"
theme.xcolor15 = xrdb.color15 or "#eaeaea"

theme.rounded_corners = true
theme.border_radius = dpi(15) -- set roundness of corners
theme.bar_item_padding = dpi(3)

-- uBorders
--
theme.border_width = dpi(2)
theme.oof_border_width = dpi(0)
theme.border_normal = "#1c2022"
theme.border_float = "#178787"
theme.border_focus = theme.xcolor3
theme.border_marked = "#3ca4d8"
theme.client_radius = dpi(12)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.xcolor0

--Titlebar
theme.titlebar_bg_normal = theme.xcolor0
theme.titlebar_bg_focus = theme.xbackground
theme.titlebar_fg_focus = theme.xforeground

-- Wibar
--
theme.wibar_height = dpi(35)
theme.wibar_position = "top"
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_border_color = theme.xcolor7
theme.wibar_bg = "#14121285"
theme.wibar_opacity = 1
theme.wibar_bg_secondary = "#00000008"
theme.bg_module = "#141717" -- pills wibar

-- Tooltips
--
theme.tooltip_bg = theme.xbackground
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. "9"
theme.tooltip_border_width = theme.widget_border_width
theme.tooltip_border_color = theme.xcolor0
theme.tooltip_gaps = dpi(20)
theme.tooltip_opacity = 1
theme.tooltip_align = "top_left"
theme.tooltip_mode = "outside"

-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.xcolor0
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(25)

--Systray
theme.systray_icon_spacing = dpi(7)
theme.bg_systray = theme.bg_module
theme.systray_icon_size = dpi(15)

-- Tabs
--
theme.mstab_bar_height = dpi(10)
theme.mstab_dont_resize_slaves = true
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.tabbar_style = "boxes"
theme.tabbar_bg_focus = theme.xbackground
theme.tabbar_bg_normal = theme.xcolor0
theme.tabbar_fg_focus = theme.xcolor8
theme.tabbar_fg_normal = theme.xcolor15 .. "55"
theme.tabbar_position = "left"
theme.tabbar_AA_radius = 0
theme.tabbar_size = 40
theme.mstab_bar_ontop = false

theme.notification_spacing = 4
theme.notif_border_radius = dpi(8)

-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_fg_focus = theme.xcolor6
theme.tasklist_bg_minimize = theme.bg_minimize .. 35
theme.tasklist_fg_minimize = theme.fg_minimize .. 55
theme.tasklist_bg_normal = theme.xcolor3 .. 90
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = false
theme.tasklist_bg_urgent = theme.xcolor4
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_align = "center"

theme.task_preview_widget_border_radius = 5 -- Border radius of the widget (With AA)
theme.task_preview_widget_bg = theme.xbackground -- The bg color of the widget
theme.task_preview_widget_border_color = theme.xcolor5 -- The border color of the widget
theme.task_preview_widget_border_width = 2 -- The border width of the widget
theme.task_preview_widget_margin = 2 -- The margin of the widget

-- Window switchr bling
theme.window_switcher_widget_bg = theme.xcolor0 -- The bg color of the widget
theme.window_switcher_widget_border_width = 2 -- The border width of the widget
theme.window_switcher_widget_border_radius = 5 -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.xcolor0 -- The border color of the widget
theme.window_switcher_clients_spacing = 5 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 250 -- The width of one client widget
theme.window_switcher_client_height = 250 -- The height of one client widget
theme.window_switcher_client_margins = 20 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 100 -- The width of one title
theme.window_switcher_name_font = "mononoki Nerd Font 10" -- The font of all titles
theme.window_switcher_name_normal_color = theme.gray -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = "#0B7985" -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center" -- How to vertically align the one icon
theme.window_switcher_icon_width = 30 -- The width of one icon

theme.flash_focus_start_opacity = 0.9 -- the starting opacity
theme.flash_focus_step = 0.01 -- the step of animation

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.taglist_font
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = "#af3a1f"
theme.taglist_bg_urgent = theme.xcolor0
theme.taglist_fg_urgent = theme.xcolor7
theme.taglist_bg_occupied = theme.bg_module
-- theme.taglist_fg_occupied = "#D2AD6F"
theme.taglist_fg_occupied = "#4B6583"
theme.taglist_bg_empty = theme.bg_module
theme.taglist_fg_empty = "#554A4A"
-- theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true
theme.taglist_shape_focus = helpers.rrect(theme.border_radius - 3)

-- Playerctl (bling)
theme.playerctl_backend = "playerctl_lib"
theme.playerctl_ignore = {}
-- theme.playerctl_player = {"mpd", "%any"}
theme.playerctl_update_on_activity = true
theme.playerctl_position_update_interval = 1

return theme

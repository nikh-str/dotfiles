--[[
     Multicolor Awesome WM theme 2.0
     github.com/lcpz
--]]

local lain  = require("lain")
-- local awful = require("awful")
-- local wibox = require("wibox")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")
local os = os

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
--Fonts
theme.font_name = "Hack Nerd Font "
theme.font = theme.font_name .. "11"
theme.icon_font_name= "Iosevka Nerd Font "
theme.icon_font = theme.icon_font_name .. "18"
theme.taglist_font                              = "Iosevka Nerd Font 14"
theme.numbers_font                              = "Hack Nerd Font 11"
--Icons
theme.updates_icon                              = ""
theme.textclock_icon                            = "  "
theme.time_icon                            = " "
theme.memory_icon                               = ""
theme.volume_icon                               = ""
theme.netdown_icon                              = ""
theme.net_icon                                  = " "
theme.gputemp_icon                              = ""
theme.cpu_icon                                  = ""
theme.power_icon                                = ""
theme.kernel_icon                               = ""
theme.mpd_icon                                  = ""
--Colors
--Widget colors
theme.separator_fg                              = "#332F2F"
theme.updates_fg                                = "#af3a1f"
theme.artist_fg                                 = "#af3a1f"
theme.textclock_fg                              = "#218092"
theme.keyboard_fg                               = "#AE8A16"
theme.date_fg                                   = "#458588"
theme.time_fg                                   = "#af3a1f"
theme.memory_fg                                 = "#b16286"
theme.volume_fg                                 = "#9F7DCF"
theme.net_fg                                    = "#83c07c"
theme.gputemp_fg                                = "#e6a80b"
theme.cpu_fg                                    = "#DFA445"
theme.power_fg                                  = "#ff6c6b"
theme.kernel_fg                                 = "#ff6c6b"
theme.mpd_fg                                    = "#30117D"
--Other colors
theme.menu_bg_normal                            = "#000000"
theme.menu_bg_focus                             = "#000000"
theme.bg_normal                                 = "#090808"
theme.bg_focus                                  = "#301515"
theme.bg_module                                 = "#2A2626"

theme.fg_occupied                               = "#54C8BF"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#A6751D"
theme.fg_focus                                  = "#ff8c00"
theme.fg_dark                                   = "#cccccc"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#54C8BF"
theme.bg_minimize                               = "#2F3837"
theme.menu_border_width                         = 0
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.useless_gap                               = 10
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- Icons for Notif Center
local icon_path = gfs.get_configuration_dir() .. "icons/"

theme.clear_icon = icon_path .. "notif-center/clear.png"
theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.notification_icon = icon_path .. "notif-center/notification.png"
theme.delete_icon = icon_path .. "notif-center/delete.png"
theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

local markup = lain.util.markup


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
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#871717"
theme.border_marked                             = "#3ca4d8"
theme.client_radius = dpi(12)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.xcolor0


-- Wibar
--
theme.wibar_height = dpi(24)
theme.wibar_position = "top"
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_border_color = theme.xcolor4
theme.wibar_bg = theme.xbackground
theme.wibar_opacity = 1
theme.wibar_bg_secondary = theme.xbackground


-- Tooltips
--
theme.tooltip_bg = theme.xbackground
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. "12"
theme.tooltip_border_width = theme.widget_border_width
theme.tooltip_border_color = theme.xcolor0
theme.tooltip_opacity = 1
theme.tooltip_align = "left"


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
theme.mstab_bar_ontop = true

theme.notification_spacing = 4
theme.notif_border_radius = dpi(16)

-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.xcolor4
theme.tasklist_fg_focus = theme.xcolor6
theme.tasklist_bg_minimize = theme.bg_minimize .. 55
theme.tasklist_fg_minimize = theme.fg_minimize .. 55
theme.tasklist_bg_normal = theme.bg_normal .. 70
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_disable_task_name = true
theme.tasklist_disable_icon = false
theme.tasklist_bg_urgent = theme.xcolor4
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_align = "center"

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.taglist_font
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = "#af3a1f"
theme.taglist_bg_urgent = theme.xcolor0
theme.taglist_fg_urgent = theme.xcolor6
theme.taglist_bg_occupied = theme.bg_module
theme.taglist_fg_occupied = "#DFA445"
theme.taglist_bg_empty = theme.bg_module
theme.taglist_fg_empty = "#554A4A"
theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true
theme.taglist_shape_focus = helpers.rrect(theme.border_radius - 3)


return theme

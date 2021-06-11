local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
local helpers = require("helpers")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-- local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local markup = lain.util.markup

local altbar = {}


--{{{ ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.volume_fg, theme.volume_icon .. " " .. volume_now.level .. "% "))
    end
})
--}}}

--{{{ Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()
local keyboard_text = wibox.widget {
    font = theme.font,
    markup = "<span foreground='" .. theme.date_fg .. "'></span>",
    align = "center",
    valign = "center",
    widget = awful.widget.keyboardlayout()
}

local keyboard_icon = wibox.widget {
    font = theme.icon_font_name .. "14",
    markup = "<span foreground='" .. theme.keyboard_fg .. "'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local keyboard_pill = wibox.widget {
    {
        {keyboard_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(2),
        {keyboard_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(7),
    right = dpi(2),
    widget = wibox.container.margin
}


--}}}

--{{{ Net
local netdowninfo = wibox.widget.textbox()
local netupinfo = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.net_fg, markup.font(theme.numbers_font, net_now.sent) .. "kb "))
        netdowninfo:set_markup(markup.fontfg(theme.font, theme.net_fg, theme.net_icon .. " " .. markup.font(theme.numbers_font, net_now.received) .. "kb "))
    end
})
--}}}

--{{{ MEM
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.memory_fg, theme.memory_icon .. " " .. markup.font(theme.numbers_font, mem_now.used) .. "M/" .. markup.font(theme.numbers_font, mem_now.total) .. "M "))
    end
})
--}}}

--{{{Updates widget
local scripts_beg = "bash -c '~/.local/bin/"
local updatestext = wibox.widget.textbox(markup.fontfg(theme.font, theme.updates_fg, theme.updates_icon .. "  "))
local updates = awful.widget.watch(string.format("%s/updates.sh", scripts_beg), 600,
   function (widget, stdout)
      widget:set_markup(markup.fontfg(theme.numbers_font, theme.updates_fg, stdout))
   end)
--}}}

--{{{------ CPU--------------
local cpuicon = wibox.widget.textbox(markup.fontfg(theme.font, theme.cpu_fg, theme.cpu_icon .. " "))
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#E3B439", cpu_now.usage .. "% "))
    end
})
--}}}

--{{{ javaCafe Tasklist Buttons ---------------------------------------------------

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
         awful.button({}, 5, function()    awful.client.focus.byidx(-1)
    end))
--}}}

--}}}

function theme.at_screen_connect(s, monitor)

--{{{ Create a tasklist widget

    s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    style    = {
        shape_border_width = 0,
        shape_border_color = theme.xcolor5,
        shape  = gears.shape.rounded_bar,
    },
    layout   = {
        spacing = 5,
        spacing_widget = {
            {
                forced_width = 30,
                color  = '#1B1B1B',
                shape        = gears.shape.circle,
                widget       = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        layout  = wibox.layout.flex.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                    forced_width= 7
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 20,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
}
---}}}

--[[
--{{{ javaCafe tasklist
-- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg = theme.module_bg,
        style = {bg = theme.xcolor0, shape = helpers.rrect(10)},
        layout = {spacing = dpi(8), layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                    {
                        awful.widget.clienticon,
                        top = dpi(1),
                        bottom = dpi(1),
                        right = dpi(1),
                        layout = wibox.container.margin
                    },
                    helpers.horizontal_pad(6),
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background
        }
    }
--}}}
--]]


   --{{{-----------------------Layout Box--------------------------------------------------------
   s.mylayoutbox = awful.widget.layoutbox(s)
   s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end)))
   ---}}}

   --{{{------------------------- Tags---------------------------------
   -- awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
   -- Create a taglist widget
   -- s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

local modkey= "Mod4"
s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }
-- Create the taglist widget
    -- s.mytaglist = require("ui.widgets.pacman_taglist")(s)
    ---}}}

   -- Create the wibox
   s.mywibox = awful.wibar({ theme.bar_position, screen = s, theme.bar_height, bg = theme.bg, fg = theme.fg_normal, theme.opacity })

 --{{{------------------- --Systray---------------------------------
local mysystray = wibox.widget.systray()
mysystray:set_base_size(theme.systray_icon_size)
local mysystray_container = {
    mysystray,
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin
}

local final_systray = wibox.widget {
    {
        mysystray_container,
        top = dpi(1),
        botttom = dpi(1),
        left = dpi(1),
        right = dpi(1),
        layout = wibox.container.margin
    },
    bg = theme.bg_module,
    shape = helpers.rrect(10),
    widget = wibox.container.background
}
---}}}

--{{{--------------------- Date Widget -----------------------------

local date_text = wibox.widget {
    font = theme.font,
    format = "%m/%d/%y",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

date_text.markup = "<span foreground='" .. theme.date_fg .. "'>" ..
                       date_text.text .. "</span>"

date_text:connect_signal("widget::redraw_needed", function()
    date_text.markup = "<span foreground='" .. theme.date_fg .. "'>" ..
                           date_text.text .. "</span>"
end)

local date_icon = wibox.widget {
    font = theme.icon_font_name .. "12",
    markup = "<span foreground='" .. theme.date_fg .. "'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local date_pill = wibox.widget {
    {
        {date_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(7),
        {date_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

---}}}

--{{{-------------------- Time Widget ------------------------

local time_text = wibox.widget {
    font = theme.font,
    format = "%l:%M %P",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. theme.time_fg .. "'>" ..
                       time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
    time_text.markup = "<span foreground='" .. theme.time_fg .. "'>" ..
                           time_text.text .. "</span>"
end)

local time_icon = wibox.widget {
    font = theme.icon_font_name .. "12",
    markup = "<span foreground='" .. theme.time_fg .. "'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}
local time_pill = wibox.widget {
    {
        {time_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(7),
        {time_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(5),
    right = dpi(5),
    widget = wibox.container.margin
}--------------------------------------
--}}}

--{{{ ----------------------------MPD-------------------------------------------
-- local mpdicon = wibox.widget.imagebox()
local mpdicon = wibox.widget.textbox(markup.fontfg(theme.font, theme.mpd_fg, theme.mpd_icon .. " "))
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = "  " .. mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
        elseif mpd_now.state == "pause" then
            artist = " 契"
            title  = " Paused "
        else
            artist = ""
            title  = ""
            --mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(theme.font, theme.artist_fg, artist) .. markup.fontfg(theme.font, "#A97D3A", title))
    end
})
--}}}

--{{{ local wrap_widget
local wrap_widget = function(w)
    local wrapped = wibox.widget {
        w,
        top = dpi(2),
        left = dpi(4),
        bottom = dpi(2),
        right = dpi(4),
        widget = wibox.container.margin
    }
    return wrapped
end
--}}}

--{{{ local wrap_widget
local make_pill = function(w, c)
    local pill = wibox.widget {
        w,
        bg = theme.bg_module,
        shape = helpers.rrect(10),
        widget = wibox.container.background
    }
    return pill
end
--}}}

---{{{ wibox-setup-javaCafe
-- Add widgets to the wibox
    s.mywibox:setup{
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
                        -- awesome_icon,
                        {
                            s.mytaglist,
                            helpers.horizontal_pad(6),
                            layout = wibox.layout.fixed.horizontal
                        },
                        spacing = 10,
                        spacing_widget = {
                            color = theme.xcolor8,
                            shape = gears.shape.powerline,
                            widget = wibox.widget.separator
                        },
                        layout = wibox.layout.fixed.horizontal
                    })),
                    -- s.mypromptbox,
                    wrap_widget(make_pill({
                        theme.mpd.widget,
                        left=dpi(8),
                        widget = wibox.container.margin
                    },theme.xcolor5)),
                },
                {wrap_widget(s.mytasklist), widget = wibox.container.constraint},
                {
                -- theme.mpd.widget,
                -- mykeyboardlayout,
                updatestext,
                updates,
                    batteryarc_widget({
                    show_current_level = true,
                    arc_thickness = 2,
                    size = 35,
                }),
                -- netdowninfo,
                -- netupinfo.widget,
                -- cpuicon,
                -- cpu.widget,
                    wrap_widget(make_pill(keyboard_pill, theme.xcolor5)),
                    wrap_widget(make_pill(memory.widget, theme.xcolor5)),
                    wrap_widget(make_pill({theme.volume.widget,
                    left=dpi(8),
                    widget = wibox.container.margin
                            }, theme.xcolor5)),
                    wrap_widget(make_pill(time_pill, theme.xcolor0 .. 55)),
                    wrap_widget(make_pill(date_pill, theme.xcolor0)),
                    -- wrap_widget(make_pill(battery_pill, theme.xcolor8 .. 55)),
                    wrap_widget(make_pill(
                                    {
                            s.mylayoutbox,
                            top = dpi(2),
                            bottom = dpi(2),
                            right = dpi(4),
                            left = dpi(4),
                            widget = wibox.container.margin
                        }, theme.xcolor8 .. 90)),
                    wrap_widget(make_pill({
                        final_systray,
                        bottom = dpi(2),
                        widget = wibox.container.margin
                    }, theme.xolor4)),
                    helpers.horizontal_pad(4),
                    layout = wibox.layout.fixed.horizontal
                }
            },
            widget = wibox.container.background,
            bg = theme.wibar_bg_secondary
        },
        { -- This is for a bottom border in the bar
            widget = wibox.container.background,
            bg = theme.xcolor4,
            forced_height = theme.widget_border_width
        }
    }
---}}}
end
return altbar

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local offsetx = dpi(56)
local offsety = dpi(300)
local screen = awful.screen.focused()

-- local icon_theme = "sheet"
-- local icons = require("icons")
-- icons.init(icon_theme)

-- local volume_icon = icons.volume
local volume_icon = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor4 .. "'><b></b></span>",
    align = 'center',
    valign = 'center',
    font = "Hack Nerd Font".. '70',
    widget = wibox.widget.textbox
}

-- create the volume_adjust component
local volume_adjust = wibox({
   screen = awful.screen.focused(),
   x = screen.geometry.width - offsetx - 8,
   y = (screen.geometry.height / 2) - (offsety / 2),
   width = dpi(48),
   height = offsety,
   -- shape = gears.shape.rect,
   shape = helpers.rrect(beautiful.notif_border_radius + 10 ),
   -- shape = gears.shape.rounded_bar,
   bg = "#000000",
   visible = false,
   border_width = 0,
   border_color = beautiful.xcolor5,
   ontop = true
})

local volume_bar = wibox.widget{
   widget = wibox.widget.progressbar,
   shape = gears.shape.rounded_bar,
   color = beautiful.xcolor4,
   background_color = beautiful.bg_focus,
   max_value = 100,
   value = 0
}

volume_adjust:setup {
   layout = wibox.layout.align.vertical,
   {
      wibox.container.margin(
         volume_bar, dpi(1), dpi(20), dpi(20), dpi(20)
      ),
      forced_height = offsety * 0.75,
      direction = "east",
      layout = wibox.container.rotate
   },
   wibox.container.margin(
        volume_icon,
      -- wibox.widget{
      --    image = volume_icon,
      --    widget = wibox.widget.imagebox
      -- },
      dpi(1), dpi(1), dpi(1), dpi(1)
   )
}

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust = gears.timer {
   timeout = 3,
   autostart = true,
   callback = function()
      volume_adjust.visible = false
   end
}

-- show volume-adjust when "volume_change" signal is emitted
awesome.connect_signal("signal::volume",
    function(volume, muted)
        if muted then
            volume_bar.value = 0
        else
            volume_bar.value = volume
        end
        -- make volume_adjust component visible
        if volume_adjust.visible then
            hide_volume_adjust:again()
        else
            volume_adjust.visible = true
            hide_volume_adjust:start()
        end
    end
)


local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local bling = require("3rd-party.bling")

-- Table of layouts to cover with awful.layout.inc, order matters.
-- awful.layout.layouts = {
--     awful.layout.suit.tile,
--     awful.layout.suit.max,
--     -- awful.layout.suit.floating,
--     awful.layout.suit.magnifier,
--     awful.layout.suit.tile.top,
--     -- awful.layout.suit.spiral.name,
--     bling.layout.centered,
--     bling.layout.mstab,
-- }

awful.layout.append_default_layouts({
	awful.layout.suit.tile,
	awful.layout.suit.max,
	-- awful.layout.suit.floating,
    awful.layout.suit.spiral,
	awful.layout.suit.tile.top,
	bling.layout.centered,
	bling.layout.mstab,
})

-- Rounded corners
client.connect_signal("manage", function(c, startup)
	if not c.fullscreen and not c.maximized then
		c.shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
		end
	end
end)
-- Fullscreen clients should not have rounded corners
local function no_rounded_corners(c)
	if c.fullscreen or c.maximized then
		c.shape = function(cr, width, height)
			gears.shape.rectangle(cr, width, height)
		end
	else
		c.shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
		end
	end
end
client.connect_signal("property::fullscreen", no_rounded_corners)
client.connect_signal("property::maximized", function(c)
	no_rounded_corners(c)
end)

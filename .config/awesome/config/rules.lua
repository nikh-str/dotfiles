-- Standard awesome library
-- local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

--  Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "Zoom",
          "Lxappearance",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "music",
          "vCoolor"
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true , x=600, y=200}},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    { rule = { class = "mpv" },
      properties = { screen = 1}
    },

    { rule = { class = "Pamac-manager" },
      properties = { screen = 1, floating=true, ontop=true, x=471, y=175, width=1084, height=783 }
    },

    { rule = { class = "Signal" },
      properties = { screen = 1, tag = "4", floating=true }
    },

   { rule = { class = "Element" },
      properties = { screen = 1, tag = "4", floating=true, ontop=true, x=471, y=175, width=1084, height=783 }
    },

   { rule = { class = "KeePassXC" },
      properties = { screen = 1, floating=true, ontop=true, x=471, y=175, width=1084, height=783 }
    },
    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "firefox" },
      properties = { screen = 1, tag = "2" } },
}
--

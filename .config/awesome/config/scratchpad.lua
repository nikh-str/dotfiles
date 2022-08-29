local bling = require("3rd-party.bling")
local dpi = require("beautiful.xresources").apply_dpi

local term_scratch = bling.module.scratchpad:new({
	command = "alacritty --class term_scratch",
	rule = { instance = "term_scratch" },
	sticky = false,
	floating = true,
	geometry = { x = dpi(425), y = dpi(184), height = dpi(740), width = dpi(1070) },
	reapply = true,
})

awesome.connect_signal("scratch::term_scratch", function()
	term_scratch:toggle()
end)

local ranger_scratch = bling.module.scratchpad:new({
	command = "alacritty --class ranger_scratch -e ranger",
	rule = { instance = "ranger_scratch" },
	sticky = false,
	floating = true,
	autoclose = false, -- Whether it should hide itself when losing focus
	geometry = { x = dpi(425), y = dpi(184), height = dpi(740), width = dpi(1070) },
	reapply = true,
})

awesome.connect_signal("scratch::ranger_scratch", function()
	ranger_scratch:toggle()
end)

-------------------------------------------------------------------
local tex_scratch = bling.module.scratchpad:new({
	command = "alacritty --class tex_scratch -e nvim /tmp/src.tex",
	rule = { instance = "tex_scratch" },
	sticky = false,
	floating = true,
	autoclose = false, -- Whether it should hide itself when losing focus
	geometry = { x = dpi(425), y = dpi(184), height = dpi(240), width = dpi(870) },
	reapply = true,
})

awesome.connect_signal("scratch::tex_scratch", function()
	tex_scratch:toggle()
end)
-----------------------------------------------------------------------

local music_scratch = bling.module.scratchpad:new({
	command = "alacritty --class music_scratch -e ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug",
	rule = { instance = "music_scratch" },
	sticky = false,
	floating = true,
	autoclose = true, -- Whether it should hide itself when losing focus
	geometry = { x = dpi(425), y = dpi(184), height = dpi(740), width = dpi(1070) },
	reapply = true,
})

awesome.connect_signal("scratch::music_scratch", function()
	music_scratch:toggle()
end)
-----------------------------------------------------------------------

local calendar_scratch = bling.module.scratchpad:new({
	command = "alacritty --class calendar_scratch -e calcurse",
	rule = { instance = "calendar_scratch" },
	sticky = false,
	floating = true,
	autoclose = false, -- Whether it should hide itself when losing focus
	geometry = { x = dpi(425), y = dpi(184), height = dpi(740), width = dpi(1070) },
	reapply = true,
})

awesome.connect_signal("scratch::calendar_scratch", function()
	calendar_scratch:toggle()
end)

-- local vimwiki_scratch = bling.module.scratchpad:new {
--     command = "alacritty --class vimwiki_scratch -e nvim -c VimwikiIndex",
--     rule = { instance = "vimwiki_scratch" },
--     sticky = false,
--     floating = true,
--     autoclose = false, -- Whether it should hide itself when losing focus
--     geometry = {x = dpi(425), y = dpi(184),height = dpi(640), width = dpi(1070)},
--     reapply = true,
-- }

-- awesome.connect_signal("scratch::vimwiki_scratch", function() vimwiki_scratch:toggle() end)

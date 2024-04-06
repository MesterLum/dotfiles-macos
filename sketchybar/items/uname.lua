local icons = require("icons")
local sbar = require("sketchybar")
local colors = require("colors")

local uname = sbar.add("item", {
	position = "right",
	-- icon = { drawing = false },
	background = {
		color = colors.bg1,
		border_width = 1,
		height = 26,
		border_color = colors.black,
	},
	icon = {
		string = "􀍜",
		align = "left",
		padding_left = 10,
	},
	label = {
		width = 10,
		align = "left",
		string = "?",
	},
	update_freq = 15,
	-- label = ":: " .. os.getenv("USER") .. " ::",
})

local function update()
	sbar.exec("osascript -e 'tell application \"Mail\" to return the unread count of inbox'", function(info)
		local str_len = string.len(info)
		local width = 8
		uname:set({ label = { string = info, width = str_len * width + 10 } })
	end)
end

uname:subscribe("routine", update)
uname:subscribe("forced", update)

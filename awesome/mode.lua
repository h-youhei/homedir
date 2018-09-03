local mode = {}
mode.modes = {}

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local textbox = {}
local box = {}

local function calculate_position(name, s)
	local dpi = beautiful.xresources.get_dpi()
	local w, h = textbox[name]:fit({dpi=dpi}, s.geometry.width, s.geometry.height)
	box.width = w
	box.height = h
	box.x = s.geometry.x + (s.geometry.width / 2) - (box.width / 2)
	box.y = s.geometry.y + (s.geometry.height / 2) - (box.height / 2)
end

local function show_box(name, scr)
	local s = scr or awful.screen.focused()
	box.screen = s
	local l = wibox.layout.fixed.horizontal
	box:setup {
		layout = l,
		{
			layout = l,
			textbox[name]
		}
	}
	calculate_position(name, s)
	box.visible = true
end

local function finish(grabber)
	keygrabber.stop(grabber)
	box.visible = false
end

local function match(bind, mod, key)
	if bind.key ~= key then return false end
	-- both table is empty
	if (bind.mod == nil or not next(bind.mod)) and not next(mod) then return true end
	if bind.mod == nil then return false end
	for _, m1 in pairs(bind.mod) do
		if not gears.table.hasitem(mod, m1) then return false end
	end
	return #bind.mod == #mod
end

local function call_key(map, mod, key, event)
	for _, bind in pairs(map) do
		if match(bind, mod, key) then
			if event == "press" then
				if type(bind.press) == "function" then
					bind.press()
					return true, bind.once
				end
			else
				if type(bind.release) == "function" then
					bind.release()
					return true, bind.once
				end
			end
		end
	end
	return false
end

function mode.add(name, title, map)
	if mode.modes[name] ~= nil then return end
	mode.modes[name] = map
	textbox[name] = wibox.widget.textbox()
	local text = " <big><b>" .. title .. "</b></big> "
	for _, bind in ipairs(map) do
		text = text .. "\n "
		local k = bind.key
		if bind.mod ~= nil and #bind.mod > 0 then
			for _, m in ipairs(bind.mod) do
				text = text .. m .. "+"
			end
		end
		text = text .. "<b>" ..  k .. "</b>\t"
		text = text .. (bind.description or "") .. " "
	end
	textbox[name]:set_markup(text)
end

function mode.enter(name, stay, s)
	show_box(name, s)
	local grabber = keygrabber.run(function(mod, key, event)
		if event == "press" and key == "Escape" then finish(grabber) end
		local success, once = call_key(mode.modes[name], mod, key, event)
		if success and (not stay or once) then finish(grabber) end
	end)
	return true
end

function mode.init()
	box = wibox({
		fg = beautiful.mode_fg or beautiful.fg_focus,
		bg = beautiful.mode_bg or beautiful.menu_bg_normal or beautiful.bg_focus,
		border_width = beautiful.mode_border_width or beautiful.border_width,
		border_color = beautiful.mode_border or beautiful.border_focus,
		visible = false,
		ontop = true
	})
end

return mode

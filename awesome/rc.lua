-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local mode = require("mode")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end
-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
local conf_dir = gears.filesystem.get_configuration_dir()
-- Themes define colours, icons, font and wallpapers.
beautiful.init(conf_dir .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
terminal_cmd = terminal .. " -e  "
editor = os.getenv("EDITOR") or "kak" or "nvim" or "vim" or "vi"
editor_cmd = terminal_cmd .. editor
browser = os.getenv("BROWSER") or "firefox"

-- Mod4 is GUI key, Mod1 is Alt key
modkey = "Mod4"
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
	local instance = nil

	return function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = 250 } })
		end
	end
end
-- }}}

-- {{{ Menu
function unminimized_menu ()
	local ts = awful.screen.focused().selected_tags
	local cs = {}
	for _, t in pairs(ts) do
		cs = gears.table.join(cs, t:clients())
	end
	local minimized_list = {}
	for _, c in ipairs(cs) do
		if c.minimized then
			table.insert(minimized_list, {
				c.name,
				function ()
					c.minimized = false
					client.focus = c
					c:raise()
				end,
				c.icon
			})
		end
	end
	if #minimized_list > 1 then
		awful.menu({ items = minimized_list }):show()
		-- select first item
		awful.key.execute({}, "Down")
	else
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end
end
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
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
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, client_menu_toggle_fn())
)

local function set_wallpaper(s)
	gears.wallpaper.set("#000000")
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	local l = awful.layout.suit.tile
	-- left screen on my machine
	if s.index == 1 then l = awful.layout.suit.tile.left end
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, l)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc(1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mylayoutbox,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			mytextclock,
		},
	}
end)
-- }}},

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
-- ))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	-- keep these binds in the case config is broken
	awful.key({ modkey, "Control" }, "q",
		awesome.quit,
		{description = "quit awesome", group = "awesome"}),
	awful.key({ modkey, "Control" }, "r",
		awesome.restart,
		{description = "reload awesome", group = "awesome"}),

	awful.key({ modkey, "Shift" }, "/",
		hotkeys_popup.show_help,
		{description="show help", group="awesome"}),
	-- history
	awful.key({ modkey }, "space",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),
	awful.key({ modkey, "Shift" }, "space",
		awful.tag.history.restore,
		{description = "go back", group = "tag"}),
	-- screen manipulation
	awful.key({ modkey }, "Tab",
		function () awful.screen.focus_relative(1) end,
		{description = "focus the next screen", group = "screen"} ),
	awful.key({ modkey, "Control" }, "Tab",
		function ()
			local selected = function (c) return c.first_tag.selected end
			for c in awful.client.iterate(selected) do
				c:move_to_screen()
			end
		end,
		{description = "swap screen", group = "screen"} ),
	-- client manipulation by direction
	awful.key({ modkey }, "Left",
		function () awful.client.focus.global_bydirection("left") end,
		{description = "focus left", group = "client"} ),
	awful.key({ modkey }, "Right",
		function () awful.client.focus.global_bydirection("right") end,
		{description = "focus right", group = "client"} ),
	awful.key({ modkey }, "Up",
		function () awful.client.focus.byidx(-1) end,
		{description = "focus previous", group = "client"} ),
	awful.key({ modkey }, "Down",
		function () awful.client.focus.byidx(1) end,
		{description = "focus next", group = "client"} ),
	awful.key({ modkey, "Control" }, "Left",
		function () awful.client.swap.global_bydirection("left") end,
		{description = "swap left", group = "client"} ),
	awful.key({ modkey, "Control" }, "Right",
		function () awful.client.swap.global_bydirection("right") end,
		{description = "swap right", group = "client"} ),
	awful.key({ modkey, "Control" }, "Up",
		function () awful.client.swap.byidx(-1) end,
		{description = "swap previous", group = "client"}),
	awful.key({ modkey, "Control" }, "Down",
		function () awful.client.swap.byidx(1) end,
		{description = "swap next", group = "client"}),

	-- Layout manipulation
	awful.key({ modkey }, "u",
		awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),

	-- Standard program
	awful.key({ modkey }, "Return",
		function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "launcher"}),

	awful.key({ modkey }, "e",
		function () awful.spawn(terminal_cmd .. "kaklip") end,
		{description = "edit clipboard"}),

	-- Screenshot
	awful.key({}, "Print",
		function () awful.spawn.with_shell(
			"scrot -u $HOME/Pictures/$(date +%F-%T).png"
		)end,
		{description = "take a screenshot of current window", group = "launcher"}),
	awful.key({"Shift"}, "Print",
		function () awful.spawn.with_shell(
			"scrot $HOME/Pictures/$(date +%F-%T).png"
		)end,
		{description = "take a screenshot", group = "launcher"}),
	-- use release callback to select area
	awful.key({"Control"}, "Print", nil,
		function () awful.spawn.with_shell(
			"scrot -s $HOME/Pictures/$(date +%F-%T).png"
		)end,
		{description = "take a screenshot selecting area", group = "launcher"}),

	-- Audio Control
	awful.key({}, "XF86AudioLowerVolume",
		function() awful.spawn("pactl set-sink-volume 0 -5%") end,
		{description = "volume down", group = "audio"}),
	awful.key({}, "XF86AudioRaiseVolume",
		function() awful.spawn("pactl set-sink-volume 0 +5%") end,
		{description = "volume up", group = "audio"}),
	awful.key({}, "XF86AudioMute",
		function() awful.spawn("pactl set-sink-mute 0 toggle") end,
		{description = "(un)mute", group = "audio"}),

	-- Power management
	awful.key({ modkey }, "Escape",
		function () mode.enter("power") end,
		{description = "into mode for power management", group = "mode"}),

	awful.key({ modkey, "Shift" }, ",",
		function () awful.tag.incmwfact(-0.05) end,
		{description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift" }, ".",
		function () awful.tag.incmwfact(0.05) end,
		{description = "increase master width factor", group = "layout"}),
	awful.key({ modkey }, "=",
		function ()
			local t = awful.screen.focused().selected_tag
			local fact = beautiful.master_width_factor or 0.5
			awful.tag.object.set_master_width_factor(t, fact)
		end,
		{description = "reset master width factor", group = "layout"}),

	-- switch layout
	awful.key({ modkey }, "l",
		function () mode.enter("layout") end,
		{description = "Switch layout", group = "layout"}),

	-- show menu to select minimized client
	-- unminimized immediatly if there is only one minimized cliend.
	awful.key({ modkey, "Control" }, "n",
		unminimized_menu,
		{description = "restore minimized", group = "client"}),

	-- Prompt
	awful.key({ modkey }, "x",
		function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = "launcher"}),

	awful.key({ modkey, "Shift" }, ";",
		function ()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{description = "lua execute prompt", group = "awesome"}),
	awful.key({ modkey }, "s",
		function () awful.spawn("websearch menu") end,
		{description = "search on google", group = "search"}),
	awful.key({ modkey, "Shift" }, "s",
		function () mode.enter("search") end,
		{description = "select engine for search", group = "search"}),
	awful.key({ modkey }, "p",
		function () awful.spawn("websearch selection") end,
		{description = "search on google with primary selection", group = "search"}),
	awful.key({ modkey, "Shift" }, "p",
		function () mode.enter("selection_search") end,
		{description = "select engine for search with primary selection", group = "search"}),

	-- Menubar
	awful.key({ modkey }, "r", function() menubar.show() end,
		{description = "show the menubar", group = "launcher"}),
	awful.key({ modkey }, "o", function() mode.enter("launcher") end,
		{description = "enter launcher mode", group = "launcher"})
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "q",
		function (c) c:kill() end,
		{description = "close", group = "client"}),
	-- TODO kill all on selected tag
	awful.key({ modkey, "Shift" }, "Tab",
		function (c) c:move_to_screen() end,
		{description = "move to screen", group = "client"}),
	awful.key({ modkey }, "f",
		awful.client.floating.toggle                     ,
		{description = "toggle floating", group = "client"}),
	awful.key({ modkey, "Shift" }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey }, "t",
		function (c) c.ontop = not c.ontop end,
		{description = "toggle keep on top", group = "client"}),
	awful.key({ modkey, }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end ,
		{description = "minimize", group = "client"}),
	awful.key({ modkey }, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "(un)maximize", group = "client"}),
	awful.key({ modkey, "Shift" }, "m",
		function (c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end ,
		{description = "(un)maximize vertically", group = "client"}),
	awful.key({ modkey, "Control"   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
		{description = "(un)maximize horizontally", group = "client"}),
	awful.key({ modkey }, "a",
		function (c) c.sticky = not c.sticky end,
		{description = "be available on all tags", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Mod1" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end

clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize))

mode.init()
mode.add("power", "Power management", {
	{
	-- TODO:doesn't work
		key = "q",
		press = awesome.quit,
		description = "quit awesome",
	}, {
		key = "c",
		press = awesome.restart,
		description = "reload awesome config",
	}, {
		key = "p",
		press = function () awful.spawn("poweroff") end,
		description = "poweroff",
	}, {
		key = "l",
		press = function () awful.spawn("slock") end,
		description = "lock screen",
	}, {
		key = "r",
		press = function () awful.spawn("reboot") end,
		description = "reboot",
	}, {
		key = "s",
		press = function () awful.spawn("systemctl suspend") end,
		description = "suspend"
	-- }, {
	-- 	key = "h",
	-- 	press = function () end,
	-- 	description = "hibernate",
	-- }, {
	-- 	key = "b",
	-- 	press = function () end,
	-- 	description = "suspend to both",
	},
})
mode.add("layout", "Switch layout", {
	{
		key = "m",
		press = function ()
			awful.layout.set(awful.layout.suit.max)
		end,
		description = "max",
	}, {
		key = "f",
		press = function ()
			awful.layout.set(awful.layout.suit.floating)
		end,
		description = "floating",
	}, {
		key = "v",
		press = function ()
			awful.layout.set(awful.layout.suit.fair)
		end,
		description = "fair (vertical)",
	}, {
		key = "h",
		press = function ()
			awful.layout.set(awful.layout.suit.fair.horizontal)
		end,
		description = "fair (horizontal)",
	}, {
		key = "l",
		press = function ()
			awful.layout.set(awful.layout.suit.tile)
		end,
		description = "tile (master is left)",
	}, {
		key = "r",
		press = function ()
			awful.layout.set(awful.layout.suit.tile.left)
		end,
		description = "tile (master is right)",
	}, {
		key = "t",
		press = function ()
			awful.layout.set(awful.layout.suit.tile.bottom)
		end,
		description = "tile (master is top)",
	}, {
		key = "b",
		press = function ()
			awful.layout.set(awful.layout.suit.tile.top)
		end,
		description = "tile (master is bottom)",
	},
})

mode.add("launcher", "Launch program", {
	{
		key = "w",
		press = function ()
			awful.spawn(browser)
		end,
		description = "web browser",
	}, {
		key = "c",
		press = function ()
			awful.spawn("libreoffice --calc")
		end,
		description = "libreoffice calc",
	},
})

local function setup_websearch(m, description, input)
	mode.add(m, description, {
		{
			key = "i",
			press = function () awful.spawn("websearch " .. input .. " image") end,
			description = "image",
		}, {
			key = "y",
			press = function () awful.spawn("websearch " .. input .. " youtube") end,
			description = "youtube",
		}, {
			key = "m",
			press = function () awful.spawn("websearch " .. input .. " map") end,
			description = "map",
		}, {
			key = "w",
			press = function () awful.spawn("websearch " .. input .. " wikipedia") end,
			description = "wikipedia",
		}, {
			key = "g",
			press = function () awful.spawn("websearch " .. input .. " github") end,
			description = "github",
		}, {
			key = "l",
			press = function () awful.spawn("websearch " .. input .. " archlinux") end,
			description = "arch linux wiki",
		}, {
			key = "p",
			press = function () awful.spawn("websearch " .. input .. " aur") end,
			description = "AUR package",
		}, {
			key = "e",
			press = function () awful.spawn("websearch " .. input .. " english") end,
			description = "english dictionary",
		}, {
			key = "j",
			press = function () awful.spawn("websearch " .. input .. " japanese") end,
			description = "japanese dictionary",
		}, {
			key = "t",
			press = function () awful.spawn("websearch " .. input .. " translation") end,
			description = "jp-en or en-jp translation dictionary",
		}
	})
end
setup_websearch("search", "Select search engine (search with menu)", "menu")
setup_websearch("selection_search", "Select search engine (search with selection)", "selection")

for s in screen do
	for out,_ in pairs(s.outputs) do
		if out == "HDMI2" then
			awful.screen.focus(out)
		end
	end
end
-- This doesn't work expected
-- awful.screen.focus(screen.primary)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
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
	{
		rule_any = {
			instance = {
				"DTA",  -- Firefox addon DownThemAll.
				"copyq",  -- Includes session name in class.
			},
			class = {
				"Arandr",
				"Gpick",
				"Kruler",
				"MessageWin",  -- kalarm.
				"Sxiv",
				"Wpa_gui",
				"pinentry",
				"veromix",
				"xtightvncviewer"
			},
			name = {
				"Event Tester",  -- xev.
			},
			role = {
				"AlarmWindow",  -- Thunderbird's calendar.
				"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = {
			floating = true,
			placement = awful.placement.centered
		}
	},

	-- Add titlebars to normal clients and dialogs
	-- { rule_any = {type = { "normal", "dialog" }
	{ rule_any =
		{type = { "dialog" }},
		properties = { titlebars_enabled = true }
	},

	{
		rule_any = { class = {
			"Firefox",
			"Chromium",
			"Kicad",
			"obs",
			"Shotcut",
			"vlc",
		} },
		properties = { maximized = true }
	},
	{
		rule_any = { class = {
			"t-engine"
		} },
		properties = { fullscreen = true }
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and
	not c.size_hints.user_position and
	not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "left",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			-- awful.titlebar.widget.floatingbutton (c),
			-- awful.titlebar.widget.minimizebutton(c),
			-- awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- local function update_pointer(c)
-- 	-- c.x,y,width,height
-- 	mouse.coords(
-- 		{
-- 			x = c.x + c.width / 2,
-- 			y = c.y + 10
-- 		},
-- 		true
-- 	)
-- end

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	-- don't trigger
	-- client.disconnect_signal("focus", update_pointer)
	if awful.client.focus.filter(c) then
		client.focus = c
	end
	-- client.connect_signal("focus", update_pointer)
end)

-- client.connect_signal("focus", update_pointer)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

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
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("ARKONF_DIR") .. "/awesome/theme.lua")

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
}
-- }}}

-- {{{ Helper functions
local function file_exists(command)
    local f = io.open(command)
    if f then f:close() end
    return f and true or false
end

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
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "edit config", "emacs-console " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "hotkeys", function() return false, hotkeys_popup.show_help end},
                                    { "open terminal", "zmux" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = "zmux" -- Set the terminal for applications that require it
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
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
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
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    if os.getenv("USER") == "nonfreegaming" and screen[1].geometry.width == 3440 then
       if s.index == 1 then
          awful.tag({ "game", "stream" }, s, awful.layout.layouts[1])
       elseif s.index == 2 then
          awful.tag.add("web", {
             screen = s,
             layout = awful.layout.layouts[1],
          })
          awful.tag.add("monitor", {
             screen = s,
             layout = awful.layout.suit.tile,
             master_width_factor = 0.67,
             selected = true
          })
       else
          awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
       end
    else
       if s.index == 1 then
          awful.tag({ "web", "code 1", "code 2", "code 3", "code 4" }, s, awful.layout.layouts[1])
       elseif s.index == 2 then
          awful.tag({ "mail", "code A", "code B", "code C", "code D" }, s, awful.layout.layouts[1])
       else
          awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
       end
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt {
       hooks = {
          {{}, "Return", function(command)
              if os.getenv("USER") ~= "nonfreegaming" and (command == "steam" or command == "teamspeak3") then
                 naughty.notify{ text = "Currently logged in as '".. os.getenv("USER") .."', consider using the 'nonfreegaming' account instead" }
              else
                 return command
              end
          end}
       }
    }
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    local right_widgets = { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        awful.widget.watch('test -h /dev/input/by-id/usb-raychengy_Fifi-event-kbd', 1, function(widget, stdout, stderr, exitreason, exitcode)
            if exitcode == 0 then
                widget:set_markup('<span bgcolor="green">KM</span>')
            else
                widget:set_markup('<span bgcolor="red">KM</span>')
            end
        end),
        mytextclock
    }
    right_widgets[#right_widgets + 1] = require("battery-widget") {}
    right_widgets[#right_widgets + 1] = s.mylayoutbox

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        right_widgets,
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

lock = 'no_screen_locker_found'
for k, v in pairs({
    'sxlock -l -f -misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1',
    'i3lock',
    'gnome-screensaver-command --lock',
}) do
    if file_exists('/usr/bin/' .. v:gsub(' .*', '')) then
        lock = v
        break
    end
end

pass = 'no_pass_manager_found'
for k, v in pairs({
    { 'keepassxc', 'KeePassXC' },
    { 'keepassx2', 'Keepassx2' },
    { 'keepassx',  'keepassx'  },
}) do
    if file_exists('/usr/bin/' .. v[1]) then
        pass = v[1]
        pass_class = v[2]
        break
    end
end

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "l", function () awful.util.spawn(lock) end,
              {description = "lock screen", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "l", function () awful.util.spawn("sudo systemctl suspend") end,
              {description = "lock screen and suspend", group = "awesome"}),
    awful.key({ modkey,           }, "k", function ()
                 local matcher = function (c)
                    return awful.rules.match(c, {class = pass_class})
                 end
                 awful.client.run_or_raise(pass, matcher)
               end,
              {description = "password manager", group = "launcher"}),
    awful.key({ modkey,           }, "v", function ()
                 local matcher = function (c)
                    return awful.rules.match(c, {class = "pavucontrol"})
                 end
                 awful.client.run_or_raise("pavucontrol", matcher)
               end,
              {description = "password manager", group = "launcher"}),
    awful.key({ "Control", "Shift"}, "Escape", function () awful.util.spawn("/usr/bin/urxvt -e /usr/bin/htop", { maximized = true }) end,
              {description = "manage tasks", group = "awesome"}),
    awful.key({ modkey,           }, "?",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
--    awful.key({ modkey,           }, "k",
--        function ()
--            awful.client.focus.byidx(-1)
--        end,
--        {description = "focus previous by index", group = "client"}
--    ),

    awful.key({ modkey, "Mod1"    }, "Left",
        function ()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key({ modkey, "Mod1"    }, "Right",
        function ()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}
    ),
    awful.key({ modkey, "Mod1"    }, "Up",
        function ()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({ modkey, "Mod1"    }, "Down",
        function ()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}
    ),

    awful.key({ modkey,           }, "Left",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.left
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.5})
            end
        end,
        {description = "Snap window on the left", group = "client"}),
    awful.key({ modkey,           }, "Right",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.right
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.5})
            end
        end,
        {description = "Snap window on the right", group = "client"}),
    awful.key({ modkey, "Shift"    }, "Left",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.left
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.73})
            end
        end,
        {description = "Snap window on the left with 16/9 ratio", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.right
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.73})
            end
        end,
        {description = "Snap window on the right with 16/9 ratio", group = "client"}),
    awful.key({ modkey, "Shift"    }, "Home",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.left
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.27})
            end
        end,
        {description = "Snap window on the left to complement a 16/9 ratio", group = "client"}),
    awful.key({ modkey, "Shift"   }, "End",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.right
                        + awful.placement.maximize_vertically
                f(client.focus, {honor_workarea=true, to_percent = 0.27})
            end
        end,
        {description = "Snap window on the right to complement 16/9 ratio", group = "client"}),
    awful.key({ modkey,           }, "Up",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.top
                        + awful.placement.maximize_horizontally
                f(client.focus, {honor_workarea=true, to_percent = 0.5})
            end
        end,
        {description = "Snap window on the top", group = "client"}),
    awful.key({ modkey,           }, "Down",
        function ()
            if client.focus then
                local f = awful.placement.scale
                        + awful.placement.bottom
                        + awful.placement.maximize_horizontally
                f(client.focus, {honor_workarea=true, to_percent = 0.5})
            end
        end,
        {description = "Snap window on the bottom", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn("zmux") end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn("zssh") end,
              {description = "open a remote terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Control" }, "a", function () awful.spawn("setxkbmap fr") end,
              {description = "Switch to French AZERTY", group = "launcher"}),
    awful.key({ modkey, "Control" }, "q", function () awful.spawn("zsh -i -c 'kbd'") end,
              {description = "Switch to Qolemax", group = "launcher"}),
    awful.key({ modkey, "Control" }, "f", function () awful.spawn("xmodmap -e 'keycode 52 = z Z guillemotleft guillemotright' -e 'keycode 94 = less greater U201C U201D'") end,
              {description = "Switch to French Qolemax", group = "launcher"}),
    awful.key({ modkey, "Control" }, "e", function () awful.spawn("xmodmap -e 'keycode 52 = z Z U201C U201D' -e 'keycode 94 = less greater guillemotleft guillemotright'") end,
              {description = "Switch to English Qolemax", group = "launcher"}),

    awful.key({ modkey,           }, "/", function () awful.spawn("sxiv -b -g 1200  -sw " .. os.getenv("HOME").. "/Images/miryoku-fresdevi-reference.png") end,
              {description = "open keyboard reference", group = "launcher"}),

    awful.key({ modkey,           }, "c", function () awful.spawn.with_shell("xcolor | tr -d '\n' | xclip -selection clipboard") end,
              {description = "open color picker", group = "launcher"}),
    awful.key({                   }, "Print", function () awful.spawn("flameshot gui") end,
              {description = "open keyboard reference", group = "launcher"}),
    awful.key({ modkey,           }, "Print", function () awful.spawn("flameshot launcher") end,
              {description = "open keyboard reference", group = "launcher"}),

    awful.key({ modkey,           }, ";", function ()
                 local matcher = function (c)
                    return awful.rules.match(c, {instance = "org-console"})
                 end
                 awful.client.run_or_raise("org-console", matcher)
              end,
              {description = "open a task list", group = "launcher"}),

    awful.key({ modkey,           }, "#87", function () awful.spawn("zsh -i -c 'edifier'") end,
              {description = "Use Edifier bluetooth speakers", group = "launcher"}),
    awful.key({ modkey,           }, "#88", function () awful.spawn("zsh -i -c 'jabra_audio'") end,
              {description = "Use Jabra bluetooth headphones", group = "launcher"}),
    awful.key({ modkey,           }, "#89", function () awful.spawn("zsh -i -c 'jabra_talk'") end,
              {description = "Use Jabra bluetooth headset", group = "launcher"}),

    awful.key({ modkey,           }, "#83", function () awful.spawn("playerctl previous") end,
              {description = "Previous track", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "#83", function () awful.spawn("playerctl position 15-") end,
              {description = "Backward 15 seconds", group = "launcher"}),
    awful.key({ modkey,           }, "#84", function () awful.spawn("playerctl play-pause") end,
              {description = "Play / pause", group = "launcher"}),
    awful.key({ modkey,           }, "#85", function () awful.spawn("playerctl next") end,
              {description = "Next track", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "#85", function () awful.spawn("playerctl position 15+") end,
              {description = "Forward 15 seconds", group = "launcher"}),

    awful.key({ modkey, "Mod1"    }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Mod1"    }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "w",      function (c) awful.placement.top_right(c)     end,
              {description = "move top right", group = "client"}),
    awful.key({ modkey,           }, "d",      function (c) awful.placement.bottom_right(c)  end,
              {description = "move bottom right", group = "client"}),
    awful.key({ modkey,           }, "s",      function (c) awful.placement.bottom_left(c)   end,
              {description = "move bottom left", group = "client"}),
    awful.key({ modkey,           }, "a",      function (c) awful.placement.top_left(c)      end,
              {description = "move top left", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
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
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
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
            "xtightvncviewer",
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
         floating = true
      }
   },
   {
      rule = {
         class = "URxvt"
      },
      properties = {
         size_hints_honor = false
      }
   },
   {
      rule_any = {
         class = {
            "Firefox",
            "Chromium",
         }
      },
      properties = {
         screen = 1,
         tag = "web",
         placement = awful.placement.left,
         width = screen[1].workarea.width * 0.73,
         maximized_vertical = true
      }
   },
   {
      rule_any = {
         class = {
            "KeePassXC",
            "pavucontrol",
         },
         instance = {
            "org-console",
         },
      },
      properties = {
         screen = 1,
         tag = "web",
         placement = awful.placement.right,
         width = screen[1].workarea.width * 0.27,
         maximized_horizontal = false,
         maximized_vertical = true,
         skip_taskbar = true
      }
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
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c) -- TODO FIXME not a good idea?
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

if os.getenv("USER") == "nonfreegaming" and screen[1].geometry.width == 3440 then
   -- awful.util.spawn("xrandr" ..
   -- "    --output DP-3" ..
   -- "         --mode 3440x1440" ..
   -- "         --scale 1x1" ..
   -- "         --pos 0x1080" ..
   -- "    --output HDMI-1" ..
   -- "         --mode 1920x1080" ..
   -- "         --scale 1x1" ..
   -- "         --pos 760x0")
   awful.util.spawn("steam -silent", {
      screen = 1,
      maximized = false
   })
   awful.util.spawn("pavucontrol", {
      screen = 1,
      maximized = false,
      placement = awful.placement.bottom_right
   })
   awful.util.spawn("firefox https://aoe2.arkanosis.net/overlay/#1573664", {
      screen = 2,
      tag = "monitor",
      maximized = false
   }, function()
      awful.util.spawn("firefox -new-window https://www.twitch.tv/directory/category/age-of-empires-ii", {
         screen = 2,
         tag = "monitor",
         maximized = false
      }, function()
         awful.util.spawn("firefox https://discord.com/channels/919681139101282344/919681139101282347", {
            screen = 2,
            tag = "monitor",
            maximized = false
         })
      end)
   end)
end

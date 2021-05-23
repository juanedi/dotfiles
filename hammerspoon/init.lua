local window_manager = require("window_manager")
local sound_menubar = require("sound_menubar")

sound_menubar:init()
hs.hotkey.bind({"cmd", "alt"}, "A", sound_menubar.nextOutput)

--------------------------------------------
-- WINDOW MANAGER BINDINGS
--------------------------------------------

-- key bindings

hs.hotkey.bind({"cmd", "alt"}, "C", window_manager.snapWindowToCenter)
hs.hotkey.bind({"cmd", "alt"}, "F", window_manager.relocate_window_full_screen)
hs.hotkey.bind({"cmd", "alt"}, "left", window_manager.snapWindowToLeft)
hs.hotkey.bind({"cmd", "alt"}, "right", window_manager.snapWindowToRight)
hs.hotkey.bind({"cmd", "alt"}, "up", window_manager.snapWindowToTop)
hs.hotkey.bind({"cmd", "alt"}, "down", window_manager.snapWindowToBottom)

hs.hotkey.bind({"shift", "cmd", "alt"}, "left", window_manager.moveToMonitorOnTheLeft)
hs.hotkey.bind({"shift", "cmd", "alt"}, "right", window_manager.moveToMonitorOnTheRight)

-- URL bindings, used by karabiner to map fn key

hs.urlevent.bind(
  "relocate_window",
  function(eventName, params)
    if params["position"] == "left" then
      window_manager.snapWindowToLeft()
    elseif params["position"] == "right" then
      window_manager.snapWindowToRight()
    elseif params["position"] == "down" then
      window_manager.snapWindowToBottom()
    elseif params["position"] == "up" then
      window_manager.snapWindowToTop()
    elseif params["position"] == "center" then
      window_manager.snapWindowToCenter()
    elseif params["position"] == "full" then
      window_manager.relocate_window_full_screen()
    end
end)

hs.urlevent.bind(
  "move_screen",
  function(eventName, params)
    if params["direction"] == "left" then
      window_manager.moveToMonitorOnTheLeft()
    elseif params["direction"] == "right" then
      window_manager.moveToMonitorOnTheRight()
    elseif params["direction"] == "down" then
      window_manager.moveToMonitorBelow()
    elseif params["direction"] == "up" then
      window_manager.moveToMonitorAbove()
    end
end)

--------------------------------------------
-- APPLICATION CONTROL
--------------------------------------------

hs.hotkey.bind({"cmd", "shift"}, "A", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"cmd", "shift"}, "D", function()
    hs.application.launchOrFocus("TickTick")
end)

hs.hotkey.bind({"cmd", "shift"}, "E", function()
    hs.application.launchOrFocus("Emacs")
end)

hs.hotkey.bind({"cmd", "shift"}, "G", function()
    hs.application.launchOrFocus("Telegram")
end)

hs.hotkey.bind({"cmd", "shift"}, "W", function()
    hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"cmd", "shift"}, "X", function()
    hs.application.launchOrFocus("iTerm")
end)

local window_manager = require("window_manager")
local sound_control = require("sound_control")

--------------------------------------------
-- SOUND CONTROL
--------------------------------------------

sound_control:init_menubar()
hs.hotkey.bind({"cmd", "alt"}, "Q", sound_control.nextOutput)
hs.urlevent.bind("sound_control_switch", sound_control.nextOutput)

--------------------------------------------
-- WINDOW MANAGER BINDINGS
--------------------------------------------

-- key bindings

hs.hotkey.bind({"cmd", "alt"}, "E", window_manager.moveMouseToNextScreen)
hs.hotkey.bind({"cmd", "alt"}, "C", window_manager.snapWindowToCenter)
hs.hotkey.bind({"cmd", "alt"}, "F", window_manager.relocate_window_full_screen)
hs.hotkey.bind({"cmd", "alt"}, "left", window_manager.snapWindowToLeft)
hs.hotkey.bind({"cmd", "alt"}, "right", window_manager.snapWindowToRight)
hs.hotkey.bind({"cmd", "alt"}, "up", window_manager.snapWindowToTop)
hs.hotkey.bind({"cmd", "alt"}, "down", window_manager.snapWindowToBottom)

hs.hotkey.bind({"shift", "cmd", "alt"}, "left", window_manager.moveToMonitorOnTheLeft)
hs.hotkey.bind({"shift", "cmd", "alt"}, "right", window_manager.moveToMonitorOnTheRight)
hs.hotkey.bind({"shift", "cmd", "alt"}, "down", window_manager.moveToMonitorBelow)
hs.hotkey.bind({"shift", "cmd", "alt"}, "up", window_manager.moveToMonitorAbove)

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

hs.urlevent.bind("move_mouse_to_next_screen", window_manager.moveMouseToNextScreen)

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

hs.hotkey.bind({"cmd", "shift"}, "J", function()
    hs.application.launchOrFocus("Dash")
end)

hs.hotkey.bind({"cmd", "shift"}, "L", function()
    hs.application.launchOrFocus("Linear")
end)

hs.hotkey.bind({"cmd", "shift"}, "W", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"cmd", "shift"}, "X", function()
    hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd", "shift"}, "F", function()
    hs.application.launchOrFocus("Notion Calendar")
end)

--------------------------------------------
-- MISC
--------------------------------------------

-- Automatically format some links when pasting into rich text inputs.
-- Stolen from https://github.com/waj <3
linkFormats = {
  {"https://github.com/.+/.+/pull/(%d+)", "#%s"},
  {"https://linear.app/.+/issue/(.+)/.+", "%s"}
}

hs.hotkey.bind({"cmd", "alt"}, "v", nil, function()
  local text = hs.pasteboard.getContents()
  for _, format in pairs(linkFormats) do
    local s, e, m = text:find(format[1])
    if s ~= nil then
      local tmp = hs.pasteboard.readAllData()
      local plain = string.format(format[2], m)
      local html = string.format("<a href=\"%s\">%s</a>", text, plain)
      hs.pasteboard.writeDataForUTI(nil, "public.utf8-plain-text", plain)
      hs.pasteboard.writeDataForUTI(nil, "public.html", html, true)
      hs.eventtap.keyStroke({"cmd"}, "v")
      hs.pasteboard.writeAllData(tmp)
    end
  end
end)

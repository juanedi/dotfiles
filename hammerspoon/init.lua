local window_manager = require("window_manager")

function mute_zoom()
  local meetingWindow = hs.window.find("Zoom")
  if not meetingWindow then return nil end

  local zoom = meetingWindow:application()
  local meetingFocused = meetingWindow == hs.window.focusedWindow()

  if zoom:selectMenuItem({"Meeting", "Unmute Audio"}) then
    if (not meetingFocused) then
      hs.alert.show("You're now unmuted!")
    end
  elseif zoom:selectMenuItem({"Meeting", "Mute Audio"}) then
    if (not meetingFocused) then
      hs.alert.show("You're now muted!")
    end
  end
end

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


hs.hotkey.bind({"cmd", "alt"}, "C", window_manager.snapWindowToCenter)
hs.hotkey.bind({"cmd", "alt"}, "F", window_manager.relocate_window_full_screen)
hs.hotkey.bind({"cmd", "alt"}, "left", window_manager.snapWindowToLeft)
hs.hotkey.bind({"cmd", "alt"}, "right", window_manager.snapWindowToRight)
hs.hotkey.bind({"cmd", "alt"}, "up", window_manager.snapWindowToTop)
hs.hotkey.bind({"cmd", "alt"}, "down", window_manager.snapWindowToBottom)

hs.urlevent.bind(
  "move_screen",
  function(eventName, params)
    if params["direction"] == "left" then
      hs.window.focusedWindow():moveOneScreenWest(false, true, 0)
    elseif params["direction"] == "right" then
      hs.window.focusedWindow():moveOneScreenEast(false, true, 0)
    elseif params["direction"] == "down" then
      hs.window.focusedWindow():moveOneScreenSouth(false, true, 0)
    elseif params["direction"] == "up" then
      hs.window.focusedWindow():moveOneScreenNorth(false, true, 0)
    end
end)

hs.hotkey.bind(
  {"shift", "cmd", "alt"},
  "left",
  function()
    hs.window.focusedWindow():moveOneScreenWest(false, true, 0)
end)

hs.hotkey.bind(
  {"shift", "cmd", "alt"},
  "right",
  function()
    hs.window.focusedWindow():moveOneScreenEast(false, true, 0)
end)

hs.hotkey.bind({"cmd", "alt"}, "return", mute_zoom)

hs.urlevent.bind(
  "mute_zoom",
  function(eventName, params)
    mute_zoom()
end)

hs.urlevent.bind(
  "open-soundsource",
  function(eventName, params)
    hs.application.launchOrFocus("SoundSource")
end)

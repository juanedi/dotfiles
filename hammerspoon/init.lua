function nextLayout(current, targets)
  local cmp = function(v1,v2)
    return math.abs(v1 - v2) < 40
  end

  local frameMatches = function(frame1, frame2, log)
    return cmp(frame1.x, frame2.x)
      and cmp(frame1.y, frame2.y)
      and cmp(frame1.w, frame2.w)
      and cmp(frame1.h, frame2.h)
  end

  for i = 1, #targets do
    if frameMatches(current, targets[i], i == 2) then
      return (i % #targets) + 1
    end
  end

  return 1
end

function cycleLayouts(generateTargets)
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()

  local targets = generateTargets(screen:fullFrame())
  local next = nextLayout(f, targets)

  win:setFrame(targets[next], 0)
end

function setLayout(generateTarget)
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local target = generateTarget(screen:frame())
  win:setFrame(target, 0)
end

function relocate_window_full_screen()
  setLayout(function(screen)
      return {
        x = screen.x,
        y = screen.y,
        h = screen.h,
        w = screen.w
      }
  end)
end

function relocate_window_center()
  cycleLayouts(function(screen)
      return {
        {
          -- two thirds wide, full height
          y = 0,
          h = screen.h,
          x = screen.w / 6,
          w = screen.w * 2 / 3
        },
        {
          -- two thirds wide, 3/6 height vertically centered
          y = screen.h * 1 / 8,
          h = screen.h * 3 / 4,
          x = screen.w * 1 / 6,
          w = screen.w * 2 / 3
        },
        {
          -- small, portrait
          y = screen.h / 6,
          h = screen.h * 2 / 3,
          x = screen.w * 7 / 24,
          w = screen.w * 10 / 24
        },
        {
          -- small, landscape
          y = screen.h / 4,
          h = screen.h / 2,
          x = screen.w / 6,
          w = screen.w * 2 / 3
        }
      }
  end)
end

function relocate_window_left()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.y,
          h = screen.h,
          x = screen.x,
          w = screen.w / 2
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.x,
          w = screen.w / 3
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.x,
          w = screen.w * 2 / 3
        }
      }
  end)
end

function relocate_window_right()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.y,
          h = screen.h,
          x = screen.w / 2,
          w = screen.w / 2
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.w * 2 / 3,
          w = screen.w / 3
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.w * 1 / 3,
          w = screen.w * 2 / 3
        }
      }
  end)
end

function relocate_window_up()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.y,
          h = screen.h / 2,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.y,
          h = screen.h / 3,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.y,
          h = screen.h * 2 / 3,
          x = screen.x,
          w = screen.w
        }
      }
  end)
end

function relocate_window_down()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.h / 2,
          h = screen.h / 2,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.h * 2 / 3,
          h = screen.h / 3,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.h / 3,
          h = screen.h * 2 / 3,
          x = screen.x,
          w = screen.w
        }
      }
  end)
end

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
      relocate_window_left()
    elseif params["position"] == "right" then
      relocate_window_right()
    elseif params["position"] == "down" then
      relocate_window_down()
    elseif params["position"] == "up" then
      relocate_window_up()
    elseif params["position"] == "center" then
      relocate_window_center()
    elseif params["position"] == "full" then
      relocate_window_full_screen()
    end
end)


hs.hotkey.bind({"cmd", "alt"}, "C", relocate_window_center)
hs.hotkey.bind({"cmd", "alt"}, "F", relocate_window_full_screen)
hs.hotkey.bind({"cmd", "alt"}, "left", relocate_window_left)
hs.hotkey.bind({"cmd", "alt"}, "right", relocate_window_right)
hs.hotkey.bind({"cmd", "alt"}, "up", relocate_window_up)
hs.hotkey.bind({"cmd", "alt"}, "down", relocate_window_down)

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

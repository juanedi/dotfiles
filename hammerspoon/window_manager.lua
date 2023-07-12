local window_manager = {}

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

function setLayout(generateTarget)
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local target = generateTarget(screen:frame())
  win:setFrame(target, 0)
end


function cycleLayouts(generateTargets)
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local targets = generateTargets(screen:frame())

  local next = nextLayout(f, targets)

  win:setFrame(targets[next], 0)
end

----------------------------------
-- PUBLIC API
----------------------------------

function window_manager.relocate_window_full_screen()
  setLayout(function(screen)
      return {
        x = screen.x,
        y = screen.y,
        h = screen.h,
        w = screen.w
      }
  end)
end

function window_manager.snapWindowToCenter()
  cycleLayouts(function(screen)
      return {
        {
          -- one half wide, full height
          y = screen.y,
          h = screen.h,
          x = screen.x + screen.w / 4,
          w = screen.w / 2
        },
        {
          -- two thirds wide, full height
          y = screen.y,
          h = screen.h,
          x = screen.x + screen.w / 6,
          w = screen.w * 2 / 3
        },
        {
          -- two thirds wide, 3/6 height vertically centered
          y = screen.y + screen.h * 1 / 8,
          h = screen.h * 3 / 4,
          x = screen.x + screen.w * 1 / 6,
          w = screen.w * 2 / 3
        },
        {
          -- small, portrait
          y = screen.y + screen.h / 6,
          h = screen.h * 2 / 3,
          x = screen.x + screen.w * 7 / 24,
          w = screen.w * 10 / 24
        },
        {
          -- small, landscape
          y = screen.y + screen.h / 4,
          h = screen.h / 2,
          x = screen.x + screen.w / 6,
          w = screen.w * 2 / 3
        },
        {
          -- full width, one half height
          y = screen.y + screen.h / 4,
          h = screen.h / 2,
          x = screen.x,
          w = screen.w
        }
      }
  end)
end

function window_manager.snapWindowToLeft()
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

function window_manager.snapWindowToRight()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.y,
          h = screen.h,
          x = screen.x + screen.w / 2,
          w = screen.w / 2
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.x + screen.w * 2 / 3,
          w = screen.w / 3
        },
        {
          y = screen.y,
          h = screen.h,
          x = screen.x + screen.w * 1 / 3,
          w = screen.w * 2 / 3
        }
      }
  end)
end

function window_manager.snapWindowToTop()
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

function window_manager.snapWindowToBottom()
  cycleLayouts(function(screen)
      return {
        {
          y = screen.y + screen.h / 2,
          h = screen.h / 2,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.y + screen.h * 2 / 3,
          h = screen.h / 3,
          x = screen.x,
          w = screen.w
        },
        {
          y = screen.y + screen.h / 3,
          h = screen.h * 2 / 3,
          x = screen.x,
          w = screen.w
        }
      }
  end)
end

function window_manager.moveMouseToNextScreen()
  local next_screen = hs.mouse.getCurrentScreen():next()

  local destination = {
    x = next_screen:frame().w / 2,
    y = next_screen:frame().h / 2
  }

  hs.mouse.setRelativePosition(destination, next_screen)
end

function window_manager.moveToMonitorOnTheLeft()
  hs.window.focusedWindow():moveOneScreenWest(false, true, 0)
end

function window_manager.moveToMonitorOnTheRight()
  hs.window.focusedWindow():moveOneScreenEast(false, true, 0)
end

function window_manager.moveToMonitorAbove()
  hs.window.focusedWindow():moveOneScreenNorth(false, true, 0)
end

function window_manager.moveToMonitorBelow()
  hs.window.focusedWindow():moveOneScreenSouth(false, true, 0)
end

return window_manager

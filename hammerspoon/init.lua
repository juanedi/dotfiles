local moveWindowHotkey = {"cmd", "alt", "ctrl"}

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

hs.hotkey.bind(
  moveWindowHotkey,
  "C",
  function()
    cycleLayouts(function(screen)
        return {
          {
            y = screen.h / 4,
            h = screen.h / 2,
            x = screen.w / 4,
            w = screen.w / 2
          },
          {
            y = screen.h / 6,
            h = screen.h * 2 / 3,
            x = screen.w / 3,
            w = screen.w / 3
          }
        }
    end)
end)

hs.hotkey.bind(
  moveWindowHotkey,
  "F",
  function()
    setLayout(function(screen)
        return {
          x = 0,
          y = 0,
          h = screen.h,
          w = screen.w
        }
    end)
end)

hs.hotkey.bind(
  moveWindowHotkey,
  "left",
  function()
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
end)

hs.hotkey.bind(
  moveWindowHotkey,
  "right",
  function()
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
end)

hs.hotkey.bind(
  moveWindowHotkey,
  "up",
  function()
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
end)

hs.hotkey.bind(
  moveWindowHotkey,
  "down",
  function()
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
end)


-- hs.hotkey.bind(moveWindowHotkey, "T", function()
--     ok,result = hs.applescript('tell Application "zoom.us" to Unmute Audio')
--     hs.alert.show(ok)
--     hs.alert.show(result)
-- end)

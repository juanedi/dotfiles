sound_control = {}

function array_find(array, predicate)
  for i,v in ipairs(array) do
    if predicate(v) then
      return i
    end
  end

  return nil
end

function array_select_first(array, predicate)
  for i,v in ipairs(array) do
    if predicate(v) then
      return v
    end
  end

  return nil
end

function array_contains(array, value)
  for _,v in ipairs(array) do
    if value == v then
      return true
    end
  end

  return false
end

function array_from_range(i, j)
  result = {}

  for x=i,j do
    table.insert(result, x)
  end

  return result
end

function array_concat(array1, array2)
  result = {}

  for _,v in ipairs(array1) do
    table.insert(result, v)
  end

  for _,v in ipairs(array2) do
    table.insert(result, v)
  end

  return result
end

local device_display_names = {}
device_display_names["Audioengine 2+  "] = "A2+"
device_display_names["CalDigit Thunderbolt 3 Audio"] = "TS3+"
device_display_names["External Headphones"] = "Headphones"
device_display_names["MacBook Pro Speakers"] = "MBP"

local skipped_devices = {"DELL U2718Q"}

local iconAscii = [[ASCII:
· · · · · · · · · · · ·
· · · · · · · · 3 · · ·
· · · · · · · 3 · 3 · ·
· · · · · · 3 · . . 3 ·
· · · · · · · 3 · 3 · ·
· · · · . · 1 . 3 · · ·
· · · 2 · 1 . · · · · ·
· · 2 · 2 . · · · · · ·
· 2 · · · 2 · · · · · ·
· · 2 . 2 · · · · · · ·
· . · 2 · · · · · · · ·
· · · · · · · · · · · ·
]]

function sound_control.nextOutput()
  local devices = hs.audiodevice.allOutputDevices()
  local current_device = hs.audiodevice.current().uid

  current_device_index = array_find(devices, function(device)
    return device:uid() == current_device
  end)

  local devices_to_try = array_concat(
    array_from_range(current_device_index + 1, rawlen(devices)),
    array_from_range(1, current_device_index - 1)
  )

  local next_device_index = array_select_first(devices_to_try, function(other_device_index)
    other_device = devices[other_device_index]
    return not array_contains(skipped_devices, other_device:name())
  end)

  if next_device_index ~= nil then
    devices[next_device_index]:setDefaultOutputDevice()
  end
end

function sound_control:init_menubar()
  self.menu = hs.menubar.new()
  updateMenu('')

  hs.audiodevice.watcher.setCallback(updateMenu)
  hs.audiodevice.watcher.start()

  self.menu:setIcon(hs.image.imageFromASCII(iconAscii))
  self.menu:setClickCallback(sound_control.nextOutput)
end

function updateMenu(arg)
  local currentOutput = hs.audiodevice.current()
  local new_title = device_display_names[currentOutput.name] or currentOutput.name
  sound_control.menu:setTitle(new_title)
end

return sound_control

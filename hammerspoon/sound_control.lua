local arrays = require("arrays")

sound_control = {}

local device_display_names = {}
device_display_names["Audioengine 2+  "] = "A2+"
device_display_names["CalDigit Thunderbolt 3 Audio"] = "TS3+"
device_display_names["External Headphones"] = "Headphones"
device_display_names["MacBook Pro Speakers"] = "MBP"
device_display_names["Jabra Elite 65t"] = "JE-65t"

local skipped_devices = {"DELL U2718Q"}

local iconAscii = [[ASCII:
· · · · · · · · · I # I
· · · · · · · · G # # #
· · · · · · · D · # # I
· · · · · · B · # · H ·
· · · 5 · 8 # # · E · ·
· · · # # · # # A · · ·
· · # # # # · 9 · · · ·
· · # # # # # · · · · ·
· · # # # # # 4 · · · ·
· · # # # # · · · · · ·
· 3 · · · · · · · · · ·
2 · · · · · · · · · · ·
]]

function sound_control.nextOutput()
  local devices = hs.audiodevice.allOutputDevices()
  local current_device = hs.audiodevice.current().uid

  current_device_index = arrays.find(devices, function(device)
    return device:uid() == current_device
  end)

  local devices_to_try = arrays.concat(
    arrays.from_range(current_device_index + 1, rawlen(devices)),
    arrays.from_range(1, current_device_index - 1)
  )

  local next_device_index = arrays.select_first(devices_to_try, function(other_device_index)
    other_device = devices[other_device_index]
    return not arrays.contains(skipped_devices, other_device:name())
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

function updateMenu()
  local currentOutput = hs.audiodevice.current()
  local new_title = device_display_names[currentOutput.name] or currentOutput.name
  sound_control.menu:setTitle(new_title)
end

return sound_control

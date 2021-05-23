sound_control = {}

device_display_names = {}
device_display_names["External Headphones"] = "Headphones"
device_display_names["MacBook Pro Speakers"] = "Macbook"

function sound_control.nextOutput()
  local devices = hs.audiodevice.allOutputDevices()
  local current_device = hs.audiodevice.current().uid

  local next_device = nil

  for i, device in pairs(devices) do
    if device:uid() == current_device then
      if devices[i+1] ~= nil then
        next_device = devices[i+1]
      else
        next_device = devices[1]
      end
    end
  end

  next_device:setDefaultOutputDevice()
end

function sound_control:init_menubar()
  self.menu = hs.menubar.new()
  updateMenu('')

  hs.audiodevice.watcher.setCallback(updateMenu)
  hs.audiodevice.watcher.start()

  self.menu:setClickCallback(sound_control.nextOutput)
end

function updateMenu(arg)
  local currentOutput = hs.audiodevice.current()
  local new_title = device_display_names[currentOutput.name] or currentOutput.name
  sound_control.menu:setTitle(new_title)
end

return sound_control

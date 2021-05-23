sound_menubar = {}

function sound_menubar.nextOutput()
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

function sound_menubar:init()
  self.menu = hs.menubar.new()
  updateMenu('')

  hs.audiodevice.watcher.setCallback(updateMenu)
  hs.audiodevice.watcher.start()
end

function updateMenu(arg)
  local currentOutput = hs.audiodevice.current()
  sound_menubar.menu:setTitle(currentOutput.name)
end

return sound_menubar

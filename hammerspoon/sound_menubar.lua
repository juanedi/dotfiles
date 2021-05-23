sound_menubar = {}

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

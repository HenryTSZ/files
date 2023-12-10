-- launch, focus or rotate application
local function switchApp(app)
  local focusedWindow = hs.window.focusedWindow()
  -- If already focused, try to find the next window
  if focusedWindow and focusedWindow:application():bundleID() == app then
    local appWindows = hs.application.get(app):allWindows()
    if app == 'com.apple.finder' then
      appWindows = hs.fnutils.filter(appWindows, function(win)
        -- If the app is Finder, remove Desktop
        return win:title() and win:title() ~= ''
      end)
    end
    if #appWindows > 0 then
      if #appWindows == 1 then
        appWindows[1]:application():hide()
      else
        -- It seems that this list order changes after one window get focused,
        -- let's directly bring the last one to focus every time
        appWindows[#appWindows]:focus()
      end
    else -- this should not happen, but just in case
      hs.application.launchOrFocusByBundleID(app)
    end
  else -- if not focused
    hs.application.launchOrFocusByBundleID(app)
  end
end

local shortcuts = {
  { 'O', 'com.tencent.WeWorkMac' },
  { 'I', 'com.colliderli.iina' },
  { 'L', 'com.googlecode.iterm2' },
  { 'K', 'com.microsoft.VSCode' },
  { 'J', 'com.microsoft.edgemac' },
  { 'H', 'com.apple.finder' },
  { ';', 'com.tencent.xinWeChat' },
}

for i, shortcut in ipairs(shortcuts) do
  hs.hotkey.bind('alt', shortcut[1], function()
    switchApp(shortcut[2])
  end)
end

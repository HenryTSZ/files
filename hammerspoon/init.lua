-- hs.loadSpoon("AppWindowSwitcher")
-- -- :setLogLevel("debug") -- uncomment for console debug log
--     :bindHotkeys({
--       ["com.apple.finder"]      = { 'alt', "h" },
--       ["com.microsoft.edgemac"] = { 'alt', "j" },
--       ["com.microsoft.VSCode"]  = { 'alt', "k" },
--       ["com.googlecode.iterm2"] = { 'alt', "l" },
--       ["com.tencent.xinWeChat"] = { 'alt', ";" },
--       ["com.colliderli.iina"]   = { 'alt', "i" },
--       ["com.tencent.WeWorkMac"] = { 'alt', "o" },
--       -- [{ "O", "o" }]            = { 'alt', "o" },
--     })

-- 定义一个函数来获取并打印当前活动应用程序的信息
local function printCurrentAppInfo()
  local currentApp = hs.application.frontmostApplication()
  local appName = currentApp:name()
  local appPath = currentApp:path()
  print(os.date("%Y-%m-%d %H:%M:%S") .. " - App name: " .. appName .. ", App path: " .. appPath)
end

-- 设置一个计时器，每1秒调用一次函数 printCurrentAppInfo
-- hs.timer.doEvery(1, printCurrentAppInfo)

require("./switchApp")

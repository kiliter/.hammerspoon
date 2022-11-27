local pathwatcher = require "hs.pathwatcher"
local alert = require "hs.alert"
local window = require "hs.window"
local utils = require("modules/utils")

function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", reloadConfig):start()
testCallbackFn = function(result)
	 print("Callback Result: " .. result) 
	end

local cscreen = hs.screen.mainScreen()
local cres = cscreen:fullFrame()
utils.notify("Mac自动化小助手","配置已重载")
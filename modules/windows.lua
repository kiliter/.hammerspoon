local window = require "hs.window"
local grid = require "hs.grid"
local windowMeta = {}
local module = {}
local application = require "hs.application"
local hotkey = require "hs.hotkey"
local layout = require "hs.layout"
local hints = require "hs.hints"
local screen = require "hs.screen"
local alert = require "hs.alert"
local fnutils = require "hs.fnutils"
local geometry = require "hs.geometry"
local mouse = require "hs.mouse"

local option = {'option'}
function Cell(x, y, w, h)
  return hs.geometry(x, y, w, h)
end

function windowMeta.new()
  local self = setmetatable(windowMeta, {
    -- Treate table like a function
    -- Event listener when windowMeta() is called
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })
  
  self.window = window.focusedWindow()
  self.screen = window.focusedWindow():screen()
  self.windowGrid = grid.get(self.window)
  self.screenGrid = grid.getGrid(self.screen)
  
  return self
end

module.bigCenter = function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 10
  f.y = max.y + max.h / 10
  f.w = max.w * 0.85
  f.h = max.h * 0.85
  
  win:setFrame(f)
end

module.smallCenter = function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 4
  f.y = max.y + max.h / 4
  f.w = max.w * 0.6 
  f.h = max.h * 0.6
  
  win:setFrame(f)
end

module.minCenter = function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y + max.h / 2
  f.w = max.w * 0.4 
  f.h = max.h * 0.4
  
  win:setFrame(f)
end

-- 使用【Option+Q】在不同屏幕之间移动鼠标
hs.hotkey.bind({'option'}, 'Q', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.absolutePosition(center)
end)

-- 使用【Option+W】在不同屏幕之间移动窗口
hs.hotkey.bind({'option'}, 'W', function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- 当前窗口 2分屏 宽度1/2 左分屏
hs.hotkey.bind({'option'}, "Left", function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- 当前窗口 2分屏 宽度1/2 右分屏
hs.hotkey.bind({'option'}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + max.w/2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- 使用【Option+up】最大化窗口
hs.hotkey.bind({'option'}, 'up', function()
  module.bigCenter()
end)

-- 使用【Option+down】居中窗口
hs.hotkey.bind({'option'}, 'down', function()
module.smallCenter()
end)

-- 使用【Option+shift+down】小号居中窗口
hs.hotkey.bind({'option,shift'}, 'up', function()
  hs.grid.maximizeWindow()
end)

-- 当前窗口 2分屏 宽度1/2 右分屏
hs.hotkey.bind({'option','shift'}, "down", function()
  module.minCenter()
end)

hs.hotkey.bind({'option','command'}, "up", function()
  local win = hs.window.focusedWindow()
  win:minimize()
end)

hs.hotkey.bind({'option'}, "N", function()
  local win = hs.window.focusedWindow()
  win:minimize()
end)

hs.hotkey.bind({'option'}, "M", function()
  local win = hs.window.focusedWindow()
  win:toggleFullScreen()
end)

hs.hotkey.bind({'option'}, "C", function()
  local win = hs.window.focusedWindow()
  win:centerOnScreen()
end)

hotkey.bind(option, '/', function()
  hints.windowHints()
end)

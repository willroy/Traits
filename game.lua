Game = class('Game'):include(Stateful)

require 'states/menu'
--require 'states/pause'
require 'states/levelone'

function Game:initialize()
  self:gotoState('Menu')
end

function Game:exit()
end

function Game:update(dt)
end

function Game:draw()
end

function Game:keypressed(key, code)
end

function Game:mousepressed(x, y, button, isTouch)
end

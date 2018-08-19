class = require 'lib/middleclass'
Stateful = require 'lib/stateful'

require 'game'

local game

function love.load()
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, code)
  game:keypressed(key, code)
end

function love.mousepressed(x, y, button, istouch)
  game:mousepressed(x, y, button, istouch)
end

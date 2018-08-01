local bump = require 'lib/bump'

local player = {
  x = 460,
  y = 460,
  width = 40,
  height = 40,
  dir = "right",
  acc = 15,
  base_speed = 8,
  img = nil,
}

local platform = {
  x = 400,
  y = 400,
  width = 153,
  height = 40,
  
  img = nil
}
function love.load()
  player.img = love.graphics.newImage('assets/character/character.png')
  platform.img = love.graphics.newImage('assets/platforms/platformgrass.png')
end

function love.update(dt)
  if love.keyboard.isDown("right", "d") and player.x < 760 then
    player.x = player.x + player.base_speed
    player.dir = "right"
  end
  if love.keyboard.isDown("left", "a") and player.x > 0 then
    player.x = player.x - player.base_speed
    player.dir = "left"
  end
  
  if love.keyboard.isDown("up", "w") then
    player.y = player.y + player.base_speed
    player.dir = "up"
  end
  if love.keyboard.isDown("down", "s") then 
    player.y = player.y - player.base_speed
    player.dir = "down"
  end  
end

function collision(object1, object2)
  if object1.x > object2.x and object1.x < object2.x+object2.width then
    if object1.y < object2.y then
      return true
    end
  end
end

function love.keypressed(key)
  if key == "escape" then
      love.event.push("quit")
  end
  if key == "x" then
    print("x: "..player.x)
    print("y: "..player.y)
  end
end

function love.draw(dt)
  love.graphics.draw(player.img, player.x, player.y)
  love.graphics.draw(platform.img, platform.x, platform.y)
  --('fill', ?, top right, ?, ?, top left, bottom)
  love.graphics.polygon('fill', 0, 400, 1600, 400, 800, 399)
  love.graphics.polygon('fill', 0, 500, 1600, 500, 0, 499)
end
local bump = require 'lib/bump'

local world
local player
local blocks = {}
local Leveltwo = Game:addState('Leveltwo')

local function addBlock(x, y)
  local block = {x=x,y=y}
  blocks[#blocks + 1] = block
  world:add(block,x,y,153,40)
end

function Leveltwo:enteredState()

  player = {
    x = 460,
    y = 460,
    w = 92,
    h = 156,
    dir = "right",
    speed = 0,
    acc = 1,
    img = nil
  }
  house1 = {
    x = 703,
    y = 200,
    w = 294,
    h = 248,
    c_w = 300,
    c_h = 248,
    r_h = 72,
    img_body = nil,
    img_roof = nil
  }

  player.img = love.graphics.newImage('assets/character/cf1.png')
  grass_tile = love.graphics.newImage('assets/tiles/tile1new.png')
  buttercup_tile = love.graphics.newImage('assets/tiles/buttercuptile.png')
  clover_tile = love.graphics.newImage('assets/tiles/clovertile.png')
  house1.img_body = love.graphics.newImage('assets/tiles/cave.png')
  house1.img_roof = love.graphics.newImage('assets/houses/house1/h1roof.png')

  house1.c_h = house1.c_h - (player.h) 

  love.mouse.setVisible(true)
  world = bump.newWorld()
  love.window.setMode(1300, 1000)
  right_x = 1260
  left_x = 0
  top_y = 0
  bot_y = 960

  world:add(house1.img_body, house1.x, house1.y+house1.r_h, house1.c_w, house1.c_h)
  world:add(player, player.x, player.y, player.w, player.h)
end

function Leveltwo:update(dt)
  local future_x, future_y = player.x, player.y
  player.speed = 6
  if love.keyboard.isDown("right", "d") and player.x < right_x then
    player.x = player.x + player.speed 
    player.img = love.graphics.newImage('assets/character/cr1.png')
  end
  if love.keyboard.isDown("left", "a") and player.x > left_x then
    player.x = player.x - player.speed 
    player.img = love.graphics.newImage('assets/character/cl1.png')
  end
  if love.keyboard.isDown("up", "w") and player.y > top_y then
    player.y = player.y - player.speed 
    player.img = love.graphics.newImage('assets/character/cb1.png')
  end
  if love.keyboard.isDown("down", "s") and player.y < bot_y then 
    player.y = player.y + player.speed 
    player.img = love.graphics.newImage('assets/character/cf1.png')
  end 

  local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
end

function Leveltwo:draw(dt)
  tile_x = 0
  tile_y = 0
  for i=138,0,-1 do
    if math.mod(i,9) == 0 or math.mod(i,4) == 0 then
      love.graphics.draw(grass_tile, tile_x, tile_y)
      --elseif i == 10 or i == 30 or i == 26 or i == 126 or i == 69 then 
      --love.graphics.draw(buttercup_tile, tile_x, tile_y)
    else
      love.graphics.draw(clover_tile, tile_x, tile_y)
    end
    tile_x = tile_x + 100
    if tile_x > 1300 then
      tile_y = tile_y + 100
      tile_x = 0
    end
  end 
  
  love.graphics.draw(house1.img_roof, house1.x, house1.y)
  love.graphics.draw(house1.img_j gt, house1.x, house1.y)
  love.graphics.draw(player.img, player.x, player.y)
  for i=1, #blocks do
    local b = blocks[i]
    love.graphics.draw(blockimg, b.x, b.y)
  end
end

function Leveltwo:keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
  if key == "x" then
    print("x: "..player.x)
    print("y: "..player.y)
  end
end

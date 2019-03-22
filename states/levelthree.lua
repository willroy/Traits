--Import the collision libary bump
local bump = require 'lib/bump'
--create a world for collision to take place
local world
--initilise the player dictionary
local player
local blocks = {}

local function addBlock(x, y)
  local block = {x=x,y=y}
  blocks[#blocks + 1] = block
  world:add(block,x,y,153,40)
end

function enteredStatelvl3()
  --player information
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
  --boulder / block information
  block1 = {
    --x and y coordinates for the location of the boulder and to keep track of
    --movement
    x = 1000,
    y = 600,
    --width and height for the boulder
    w = 100,
    h = 100,
    --which position is the correct position
    yes = "up",
    --the image of the block / boulder
    img = nil,
    --in the correct position?
    correct = false
  }
  block2 = {
    x = 200,
    y = 600,
    w = 100,
    h = 100,
    yes = "down",
    img = nil,
    correct = false
  }
  --door information
  door = {
    --location of door
    x = 600,
    y = 600,
    --dimensions of door
    w = 100,
    h = 155,
    --image of door
    img = nil
  }

  --set door position to closed
  open = false
  --set player base speed
  player.speed = 6

  --load images
  player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_front.png')
  grass_tile = love.graphics.newImage('assets/TILE/TILE_v2_leaves.png')
  background = love.graphics.newImage('assets/TILE/TILE_backing.png')
  buttercup_tile = love.graphics.newImage('assets/TILE/TILE_buttercup.png')
  clover_tile = love.graphics.newImage('assets/TILE/TILE_clover.png')
  vines = love.graphics.newImage('assets/TILE/TILE_vines.png')
  boulder = love.graphics.newImage('assets/TILE/TILE_boulder.png')
  block1.img = love.graphics.newImage('assets/TILE/TILE_boulder.png')
  block2.img = love.graphics.newImage('assets/TILE/TILE_boulder.png')
  path = love.graphics.newImage('assets/TILE/TILE_path.png')
  door.img = love.graphics.newImage('assets/ENTRY/ENTRY_finaldoor_closed.png')

  --set mouse to invisible
  love.mouse.setVisible(true)
  --initilise world for collision with bump libary
  world = bump.newWorld()
  --world boundaries
  right_x = 1260
  left_x = 0
  top_y = 0
  bot_y = 960

  --set timer to 0 to start with
  countlvl3 = 0

  --add player to bump world
  world:add(player, player.x, player.y, player.w, player.h)
end

--function for the update loop
function updatelvl3(dt)
  --add one to the count each tick 
  countlvl3 = countlvl3 + 1
  --set the futture x and yto the current x and y for bump.lua
  local future_x, future_y = player.x, player.y

  if love.keyboard.isDown("right", "d") and player.x < right_x then
    --add to x coordinate to go right
    player.x = player.x + player.speed 
    --set image to facing right when press right key
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_right.png')
  end
  if love.keyboard.isDown("left", "a") and player.x > left_x then
    player.x = player.x - player.speed 
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_left.png')
  end
  if love.keyboard.isDown("up", "w") and player.y > top_y then
    player.y = player.y - player.speed 
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_back.png')
  end
  if love.keyboard.isDown("down", "s") and player.y < bot_y then 
    player.y = player.y + player.speed 
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_front.png')
  end 
  --player base speed is 6
  player.speed = 6 
  --run the block_move function with both blocks
  block_move(block1)
  block_move(block2)
  --if both blocks are in position then the door is open
  if block1.correct == true and block2.correct == true then
    open = true
  end
  --if player standing next to door and the door is open then go to the results
  if player.x > door.x and player.x < door.x+30 and player.y > 590 and player.y < 650 then
    if open == true then
      open = false
      return "results", countlvl3
    end
  end

  --check collisions with player
  local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
  --return the level three to keep it going and count to update time for level
  return "levelthree", countlvl3
end

function block_move(blk)
  --if the player is below the block
  if player.y+(player.h/2) > (blk.y+blk.h) and player.y+(player.h/2) < (blk.y+blk.h)+20 then
    if player.x > blk.x-20 and player.x < blk.x+blk.w then
      --if the keyboard up button is pressed (moving up)
      if love.keyboard.isDown("up", "w") then
        --move block up unless it is at top
        if blk.y > 500 then
          player.speed = 3
          blk.y = blk.y - player.speed
        end
      end
    end
  end
  --if the player is above the block
  if player.y+player.h > blk.y-20 and player.y+player.h < blk.y then
    if player.x > blk.x-20 and player.x < blk.x+blk.w then
      --if the down key is pressed (moving down)
      if love.keyboard.isDown("down", "s") then
        --move block down unless it is at bottom
        if blk.y < 700 then
          player.speed = 3
          blk.y = blk.y + player.speed
        end
      end
    end
  end
  --if block is in correct position, then set the image to the block with
  --a tick
  if (blk.y == 702 and blk.yes == "down") or (blk.y == 498 and blk.yes == "up") then
    blk.img = love.graphics.newImage('assets/TILE/TILE_boulderyes.png')
    --set correct to true
    blk.correct = true
  else
    --otherwise keep the image the normal block
    blk.img = love.graphics.newImage('assets/TILE/TILE_boulder.png')
  end
end

function drawlvl3(dt)
  --set a pointer to 0 and 300 for the coordinates of the first tile
  tile_x = 0
  tile_y = 300
  --loop 138 time
  for i=138,0,-1 do
    --every square in the grid on the level that is divisible by 9 or 4 is
    --a grass tile
    if math.mod(i,9) == 0 or math.mod(i,4) == 0 then
      love.graphics.draw(grass_tile, tile_x, tile_y)
    else
      --every other tile is a clover tile
      love.graphics.draw(clover_tile, tile_x, tile_y)
    end
    --add 100 to tile_x, to go to next column of the background to draw
    tile_x = tile_x + 100
    if tile_x > 1300 then
      --go to next row of background to draw
      tile_y = tile_y + 100
      --reset x to first column
      tile_x = 0
    end
  end 
  --set a pointer to 0 and 0 for the coordinates of the first tile of vines
  vinesx = 0
  vinesy = 0 
  for a=13,0,-1 do
    --draw a vine image and then go to the next column until the whole width of
    --the window is filled
    love.graphics.draw(vines, vinesx, vinesy)
    vinesx = vinesx + 300
  end 

  --if the door is open then set the door image to the open position
  if open == true then
    door.img = love.graphics.newImage('assets/ENTRY/ENTRY_finaldoor_open.png')
  end

  --draw the door, paths, blocks and player
  love.graphics.draw(door.img, door.x, door.y)

  love.graphics.draw(path, 1000, 500)
  love.graphics.draw(path, 200, 500)

  love.graphics.draw(block1.img, block1.x, block1.y)
  love.graphics.draw(block2.img, block2.x, block2.y)

  love.graphics.draw(player.img, player.x, player.y)
  for i=1, #blocks do
    local b = blocks[i]
    love.graphics.draw(blockimg, b.x, b.y)
  end
end

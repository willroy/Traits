--Import the collision libary bump
local bump = require 'lib/bump'
--create a world for collision to take place
local world
--initilise the player dictionary
local player

--entered state function for level 1, handles setting varibles for player and
--other objects, as well as a few other things.
function enteredStatelvl1()  
  player = {
    --setting the intial x and y coordinate of the player to 460 and 460 (centre
    --of the screen)
    x = 460,
    y = 460,
    w = 92,
    h = 156,
    --direction the player is facing 
    dir = "right",
    --speed the player goes at
    speed = 0,
    --accelaration of the player
    acc = 1,
    --the image that is drawn at the player's coordinates
    img = nil
  }

  cave = {
    --cave x and y coordinates (where it is drawn)
    x = 500,
    y = 0,
    --width and height of cave image
    w = 300,
    h = 300,
    --collision width and height for cave
    c_w = 2000,
    c_h = 160,
    --image drawn for cave
    img = nil
  }

  --button objects
  button1 = {
    --x and y location of a button
    x = 700, 
    y = 800, 
    --how long the button stays pressed for
    delay = 300, 
    --if the button is pressed or not
    pressed = false, 
    --how much time the button has been pressed for
    count = 0,
    --An identifier for the button (1, 2, 3 or 4)
    id = 1
  } 
  button2 = {
    x = 500, 
    y = 800, 
    delay = 300, 
    pressed = false, 
    count = 0,
    id = 2
  } 
  button3 = {
    x = 700, 
    y = 600, 
    delay = 300, 
    pressed = false, 
    count = 0,
    id = 3
  } 
  button4 = {
    x = 500, 
    y = 600, 
    delay = 300, 
    pressed = false, 
    count = 0,
    id = 4
  } 

  --list for button press order
  order = {}

  --importing the images for the player, cave, tiles, background and buttons
  player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_front.png')
  cave.img = love.graphics.newImage('assets/ENTRY/ENTRY_cave_closed.png')
  grass_tile = love.graphics.newImage('assets/TILE/TILE_v2_leaves.png')
  background = love.graphics.newImage('assets/TILE/TILE_backing.png')
  buttercup_tile = love.graphics.newImage('assets/TILE/TILE_buttercup.png')
  clover_tile = love.graphics.newImage('assets/TILE/TILE_clover.png')
  button_up = love.graphics.newImage('assets/BUTTON/BUTTON_generalup.png')
  button_down = love.graphics.newImage('assets/BUTTON/BUTTON_generaldown.png')


  count = 0
  --set time taken for level to 0
  countlvl1 = 0

  --wether or not the mouse is visible during gameplay (it is not)
  love.mouse.setVisible(true)
  --create a new world for bump to create collisions in 
  world = bump.newWorld()
  --right, left, bottom and top coordinates for the screen
  right_x = 1260
  left_x = 0
  top_y = 0
  bot_y = 960

  --add the cave and player to the bump world so that they have collision
  world:add(cave.img, cave.x-900, cave.y, cave.c_w, cave.c_h)
  --has the image, x, y coordinate and width and height for the collsions 
  world:add(player, player.x, player.y, player.w, player.h)
end

function updatelvl1(dt)
  --add one to time taken
  countlvl1 = countlvl1 + 1
  --setting future x and y to the current x and y coordinates
  local future_x, future_y = player.x, player.y
  --the player speed is 6 (nubmer of pixels moved per tick)
  player.speed = 6
  --if the d or right key is pressed, and the player is within the right
  --bounds, then move right
  if love.keyboard.isDown("right", "d") and player.x < right_x then
    player.x = player.x + player.speed 
    --set the player image to the facing right position
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_right.png')
  end
  --if the a or left key is pressed, and the player is within the left
  --bounds, then move right
  if love.keyboard.isDown("left", "a") and player.x > left_x then
    player.x = player.x - player.speed 
    --set the player image to the facing left position
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_left.png')
  end
  --if the w or up key is pressed, and the player is within the top
  --bounds, then move right
  if love.keyboard.isDown("up", "w") and player.y > top_y then
    player.y = player.y - player.speed 
    --set the player image to the facing back position
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_back.png')
  end
  --if the s or down key is pressed, and the player is within the bottom
  --bounds, then move right
  if love.keyboard.isDown("down", "s") and player.y < bot_y then 
    player.y = player.y + player.speed 
    --set the player image to the facing front position
    player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_front.png')
  end 

  --if the player x coordinate is within the cave width location and the player
  --is at the y coordinate of the cave, then (if the cave is open), go to level
  --two.
  if player.x > cave.x+100 and player.x < cave.x+200 and player.y == 160 then
    if open == true then
      --set open to false
      open = false
      --return leveltwo to set as the new state and the final count for the
      --level
      return "leveltwo", countlvl1
    end
  end

  --only move the player if there is no collision with anything if moving that
  --way
  local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
  --return state and count at the end of each update loop
  return "levelone", countlvl1
end

function drawlvl1(dt)
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

  --if the order of the buttons is 1,4,3,2 then the cave is open
  if order[1] == 1 then
    if order[2] == 4 then
      if order[3] == 3 then
        if order[4] == 2 then
          open = true
        end
      end
    end
  end

  --run the button function for each of the buttons in the entered state
  --function
  button(button1)
  button(button2)
  button(button3)
  button(button4)

  --if the cave is open, then set the cave image to the open image
  if open == true then
    cave.img = love.graphics.newImage('assets/ENTRY/ENTRY_cave_open.png')
  end

  --draw the cave, background to the sides of cave and player
  love.graphics.draw(cave.img, cave.x, cave.y)
  love.graphics.draw(background, cave.x-300, cave.y)
  love.graphics.draw(background, cave.x-600, cave.y)
  love.graphics.draw(background, cave.x+300, cave.y)
  love.graphics.draw(background, cave.x+600, cave.y)
  --draw player last to draw on top of all the rest of the images
  love.graphics.draw(player.img, player.x, player.y)
end

function button(b)
  --if the time the button has been pressed is the max, then the button is no
  --longer pressed
  if b.count == b.delay then
    b.pressed = false 
    order = {}
  end
  --if the button is pressed then add 1 to the count each tick
  if b.pressed == true then
    b.count = b.count + 1
    --draw the button in the pressed position as the x and y coordinates of the
    --button
    love.graphics.draw(button_down, b.x, b.y)
  end
  --if the player's position is on top of the button
  if player.x > b.x-23 and player.x < (b.x+100)-23 and (player.y+player.h) > b.y and (player.y+player.h) < b.y+100 then
    --button has been pressed so set pressed to true
    b.pressed = true
    --if last button pressed was this button, then do nothing
    --if another button has been pressed, then add the id to the order list.
    if order[#order] == b.id then
    else
      order[#order+1] = b.id
    end

    b.count = 0
    love.graphics.draw(button_down, b.x, b.y) 
  elseif b.pressed == true then
    b.count = b.count + 1
    love.graphics.draw(button_down, b.x, b.y)
  else
    b.count = 0
    love.graphics.draw(button_up, b.x, b.y)
  end
end

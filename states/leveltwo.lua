local bump = require 'lib/bump'
local world
local player
local blocks = {}

local function addBlock(x, y)
  local block = {x=x,y=y}
  blocks[#blocks + 1] = block
  world:add(block,x,y,153,40)
end

function enteredStatelvl2()
  --player information
  player = {
    x = 600,
    y = 460,
    w = 92,
    h = 156,
    dir = "right",
    speed = 0,
    acc = 1,
    img = nil
  }
  --house information
  house1 = {
    --x and y coordinates for the location of the house
    x = 500,
    y = 240,
    --width and height of the house image
    w = 294,
    h = 248,
    --collision width and height for the size of the collision box
    c_w = 300,
    c_h = 248,
    --roof height
    r_h = 72,
    --images for roof and body
    img_body = nil,
    img_roof = nil
  }
  --button information
  button1 = {
    --x and y coordinate for the button location
    x = 200, 
    y = 500, 
    --delay of the button
    delay = 7000, 
    --whether or not the button is pressed
    pressed = false, 
    --how many ticks have gone by since the button was pressed
    count = 0,
    --the id of the button (unique identifier)
    id = 1,
    --image of the button
    img = nil,
    --the sound file the button plays on press
    note = love.audio.newSource("assets/AUDIO/Piano1.wav", "static")
  } 
  button2 = {
    x = 400, 
    y = 600, 
    delay = 7000, 
    pressed = false, 
    count = 0,
    id = 2,
    img = nil,
    note = love.audio.newSource("assets/AUDIO/Piano4.wav", "static")
  } 
  button3 = {
    x = 800, 
    y = 600, 
    delay = 7000, 
    pressed = false, 
    count = 0,
    id = 3,
    img = nil,
    note = love.audio.newSource("assets/AUDIO/Piano3.wav", "static")
  } 
  button4 = {
    x = 1000, 
    y = 500, 
    delay = 7000, 
    pressed = false, 
    count = 0,
    id = 4,
    img = nil,
    note = love.audio.newSource("assets/AUDIO/Piano2.wav", "static")
  } 
  resetbutton = {
    x = 100, 
    y = 800, 
    delay = 500, 
    pressed = false, 
    count = 0,
    id = 5,
    img = nil
  } 

  --list to keep track of order of button presses
  order = {}

  --load images
  player.img = love.graphics.newImage('assets/PLAYER/PLAYER_v2_front.png')
  stone_tile = love.graphics.newImage('assets/TILE/TILE_stone.png')
  background = love.graphics.newImage('assets/TILE/TILE_backing.png')
  buttercup_tile = love.graphics.newImage('assets/TILE/TILE_buttercup.png')
  stone2_tile = love.graphics.newImage('assets/TILE/TILE_stone2.png')
  button_up = love.graphics.newImage('assets/BUTTON/BUTTON_generalup.png')
  button_down = love.graphics.newImage('assets/BUTTON/BUTTON_generaldown.png')
  button_up_reset = love.graphics.newImage('assets/BUTTON/BUTTON_generalupreset.png')
  button_down_reset = love.graphics.newImage('assets/BUTTON/BUTTON_generaldownreset.png')
  house1.img_body = love.graphics.newImage('assets/ENTRY/ENTRY_house1_body.png')
  house1.img_roof = love.graphics.newImage('assets/ENTRY/ENTRY_house1_roof.png')
  vines = love.graphics.newImage('assets/TILE/TILE_vines.png')
  --load sound files for the buttons
  piano1 = love.audio.newSource("assets/AUDIO/Piano1.wav", "static")
  piano2 = love.audio.newSource("assets/AUDIO/Piano2.wav", "static")
  piano3 = love.audio.newSource("assets/AUDIO/Piano3.wav", "static")
  piano4 = love.audio.newSource("assets/AUDIO/Piano4.wav", "static")

  --set the initial images for the buttons
  button1.img = button_up
  button2.img = button_up
  button3.img = button_up
  button4.img = button_up
  resetbutton.img = button_up_reset

  count = 0
  --set the time for the level to 0 to start the timer
  countlvl2 = 0

  --make mouse invisible on the window
  love.mouse.setVisible(true)
  world = bump.newWorld()
  right_x = 1260
  left_x = 0
  top_y = 0
  bot_y = 960

  --set the bottom collision of the house higher so that the player can go up to door
  house1.c_h = house1.c_h - player.h
  --add house and player to bump collision world
  world:add(house1.img_body, house1.x, house1.y+house1.r_h, house1.c_w, house1.c_h)
  world:add(player, player.x, player.y, player.w, player.h)
end

function updatelvl2(dt)
  --add 1 to count each update loop, to track time
  countlvl2 = countlvl2 + 1
  --set the future x and y to the current x an y
  local future_x, future_y = player.x, player.y
  player.speed = 6
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

  --if the player is standing at the house's door, then check if the door is
  --open
  if player.x > house1.x and player.x < house1.x + house1.w and player.y > 400 and player.y < 410 then
    if open == true then
      --if it is open then return levelthree to go to next level
      return "levelthree", countlvl2
    end
  end

  --if the player is at the top border then move them down
  if player.y < 300-player.h then
    player.y = player.y + player.speed    
  end

  --check for player collisions and stop player progression if collision occurs
  local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
  --return leveltwo to keep going after loop
  return "leveltwo", countlvl2
end

function drawlvl2(dt)
  --set a pointer to 0 and 300 for the coordinates of the first tile
  tile_x = 0
  tile_y = 300
  --loop 138 time
  for i=138,0,-1 do
    --every square in the grid on the level that is divisible by 9 or 4 is
    --a stone
    if math.mod(i,9) == 0 or math.mod(i,4) == 0 then
      love.graphics.draw(stone_tile, tile_x, tile_y)
    else
      --every other tile is a different stone tile
      love.graphics.draw(stone2_tile, tile_x, tile_y)
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

  --if the order of the buttons is 1,4,3,2 then the house is open
  if order[1] == 1 then
    if order[2] == 4 then
      if order[3] == 3 then
        if order[4] == 2 then
          house1.img_body = love.graphics.newImage('assets/ENTRY/ENTRY_house1_bodyopen.png')
          open = true
        end
      end
    end
  end

  --run the button function for each of the buttons in the entered state
  --function
  drawbutton(button1)
  drawbutton(button2)
  drawbutton(button3)
  drawbutton(button4)
  --different function for the reset button
  drawbuttonreset(resetbutton)

  --set a pointer to 0 and 0 for the coordinates of the first tile of vines
  vinesx = 0
  vinesy = 0 
  for a=13,0,-1 do
    --draw a vine image and then go to the next column until the whole width of
    --the window is filled
    love.graphics.draw(vines, vinesx, vinesy)
    vinesx = vinesx + 300
  end 

  --draw player and house (drawing roof over player so player can go behind
  --house)
  love.graphics.draw(house1.img_body, house1.x, house1.y+house1.r_h)
  love.graphics.draw(player.img, player.x, player.y)
  love.graphics.draw(house1.img_roof, house1.x, house1.y)

  for i=1, #blocks do
    local b = blocks[i]
    love.graphics.draw(blockimg, b.x, b.y)
  end
end

function drawbuttonreset(rb)
  --play the notes at certain intervals in the count timer
  if rb.count > 0 and rb.count < 100 then
    button1.note:play()    
  end
  if rb.count > 120 and rb.count < 220 then
    button4.note:play()    
  end
  if rb.count > 240 and rb.count < 340 then
    button3.note:play()    
  end
  if rb.count > 360 and rb.count < 460 then
    button2.note:play()    
  end
  --if the time the button has been pressed is the max, then the button is no
  --longer pressed
  if rb.count == rb.delay then
    rb.img = button_up_reset
    rb.pressed = false 
    order = {}
  end
  --if the button is pressed then add 1 to the count each tick
  if rb.pressed == true then
    button1.count = 6950
    button2.count = 6950
    button3.count = 6950
    button4.count = 6950
    rb.count = rb.count + 1
    --draw the button in the pressed position as the x and y coordinates of the
    --button
    love.graphics.draw(rb.img, rb.x, rb.y)
  end
  --if the player's position is on top of the button
  if player.x > rb.x-23 and player.x < (rb.x+100)-23 and (player.y+player.h) > rb.y and (player.y+player.h) < rb.y+100 then
    --button has been pressed so set pressed to true
    rb.pressed = true
    rb.count = 0
    rb.img = button_down_reset
    love.graphics.draw(rb.img, rb.x, rb.y) 
  elseif rb.pressed == true then
    rb.count = rb.count + 1
    love.graphics.draw(rb.img, rb.x, rb.y)
  else
    rb.count = 0
    love.graphics.draw(rb.img, rb.x, rb.y)
  end
end

function drawbutton(b)
  --play the note sound file for the button for 10 ticks
  if b.count < 10 and b.count > 0 then
    b.note:play()
  end
  --if the time the button has been pressed is the max, then the button is no
  --longer pressed
  if b.count == b.delay then
    b.img = button_up
    b.pressed = false 
    order = {}
  end
  --if the button is pressed then add 1 to the count each tick
  if b.pressed == true then
    b.count = b.count + 1
    --draw the button in the pressed position as the x and y coordinates of the
    --button
    love.graphics.draw(b.img, b.x, b.y)
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
    b.img = button_down
    love.graphics.draw(b.img, b.x, b.y) 
  elseif b.pressed == true then
    b.count = b.count + 1
    love.graphics.draw(b.img, b.x, b.y)
  else
    b.count = 0
    love.graphics.draw(b.img, b.x, b.y)
  end
end


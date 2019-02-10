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
    house1 = {
        x = 500,
        y = 240,
        w = 294,
        h = 248,
        c_w = 300,
        c_h = 248,
        r_h = 72,
        img_body = nil,
        img_roof = nil
    }
    button1 = {
        x = 200, 
        y = 500, 
        delay = 7000, 
        pressed = false, 
        count = 0,
        id = 1,
        img = nil,
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
        delay = 100, 
        pressed = false, 
        count = 0,
        id = 5,
        img = nil
    } 
    
    order = {}
    
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
    piano1 = love.audio.newSource("assets/AUDIO/Piano1.wav", "static")
    piano2 = love.audio.newSource("assets/AUDIO/Piano2.wav", "static")
    piano3 = love.audio.newSource("assets/AUDIO/Piano3.wav", "static")
    piano4 = love.audio.newSource("assets/AUDIO/Piano4.wav", "static")

    button1.img = button_up
    button2.img = button_up
    button3.img = button_up
    button4.img = button_up
    resetbutton.img = button_up

    count = 0
    
    love.mouse.setVisible(true)
    world = bump.newWorld()
    right_x = 1260
    left_x = 0
    top_y = 0
    bot_y = 960
    
    house1.c_h = house1.c_h - player.h
    world:add(house1.img_body, house1.x, house1.y+house1.r_h, house1.c_w, house1.c_h)
    world:add(player, player.x, player.y, player.w, player.h)
end

function updatelvl2(dt)
  local future_x, future_y = player.x, player.y
  player.speed = 6
  if love.keyboard.isDown("right", "d") and player.x < right_x then
    player.x = player.x + player.speed 
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

  if player.x > house1.x and player.x < house1.x + house1.w and player.y > 400 and player.y < 410 then
    if open == true then
      print(open)
      love.graphics.clear( )
      return "levelthree"
    end
  end

  if player.y < 300-player.h then
    player.y = player.y + player.speed    
  end

  local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
  return "leveltwo"
end

function drawlvl2(dt)
    tile_x = 0
    tile_y = 300
    for i=138,0,-1 do
        if math.mod(i,9) == 0 or math.mod(i,4) == 0 then
            love.graphics.draw(stone_tile, tile_x, tile_y)
        else
            love.graphics.draw(stone2_tile, tile_x, tile_y)
        end
        tile_x = tile_x + 100
        if tile_x > 1300 then
            tile_y = tile_y + 100
            tile_x = 0
        end
    end 
    
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

    drawbutton(button1)
    drawbutton(button2)
    drawbutton(button3)
    drawbutton(button4)
    drawbuttonreset(resetbutton)

    vinesx = 0
    vinesy = 0 
    for a=13,0,-1 do
        love.graphics.draw(vines, vinesx, vinesy)
        vinesx = vinesx + 300
    end 

    love.graphics.draw(house1.img_body, house1.x, house1.y+house1.r_h)
    love.graphics.draw(player.img, player.x, player.y)
    love.graphics.draw(house1.img_roof, house1.x, house1.y)
    
    for i=1, #blocks do
        local b = blocks[i]
        love.graphics.draw(blockimg, b.x, b.y)
    end
end

function drawbuttonreset(rb)
    if rb.count == rb.delay then
        rb.img = button_up_reset
        rb.pressed = false 
        order = {}
    end
    if rb.pressed == true then
        button1.count = 6950
        button2.count = 6950
        button3.count = 6950
        button4.count = 6950
        rb.count = rb.count + 1
        love.graphics.draw(rb.img, rb.x, rb.y)
    end
    if player.x > rb.x-23 and player.x < (rb.x+100)-23 and (player.y+player.h) > rb.y and (player.y+player.h) < rb.y+100 then
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
    if b.count == b.delay then
        b.img = button_up
        b.pressed = false 
        order = {}
    end
    if b.pressed == true then
        b.note:play()
        b.count = b.count + 1
        love.graphics.draw(b.img, b.x, b.y)
    end
    if player.x > b.x-23 and player.x < (b.x+100)-23 and (player.y+player.h) > b.y and (player.y+player.h) < b.y+100 then
        b.pressed = true
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


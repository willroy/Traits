local bump = require 'lib/bump'
local world
local player
local blocks = {}

local function addBlock(x, y)
    local block = {x=x,y=y}
    blocks[#blocks + 1] = block
    world:add(block,x,y,153,40)
end

function enteredStatelvl1()
    print("init")
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
    
    cave = {
        x = 500,
        y = 0,
        w = 300,
        h = 300,
        c_w = 2000,
        c_h = 160,
        img = nil
    }
    
    button1 = {
        x = 700, 
        y = 800, 
        delay = 300, 
        pressed = false, 
        count = 0,
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
    
    order = {}
    
    player.img = love.graphics.newImage('assets/character/cf1.png')
    cave.img = love.graphics.newImage('assets/tiles/cave.png')
    grass_tile = love.graphics.newImage('assets/tiles/tile1new.png')
    background = love.graphics.newImage('assets/tiles/backing.png')
    buttercup_tile = love.graphics.newImage('assets/tiles/buttercuptile.png')
    clover_tile = love.graphics.newImage('assets/tiles/clovertile.png')
    button_up = love.graphics.newImage('assets/interactable/buttonup.png')
    button_down = love.graphics.newImage('assets/interactable/buttondown.png')
    
    count = 0
    
    love.mouse.setVisible(true)
    world = bump.newWorld()
    right_x = 1260
    left_x = 0
    top_y = 0
    bot_y = 960
    
    world:add(cave.img, cave.x-900, cave.y, cave.c_w, cave.c_h)
    world:add(player, player.x, player.y, player.w, player.h)
end

function updatelvl1(dt)
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
    
    if player.x > cave.x+100 and player.x < cave.x+200 and player.y == 160 then
        if open == true then
            return "leveltwo"
        end
    end
    
    local newX, newY, cols, len = world:move(player, player.x, player.y) player.x, player.y = newX, newY
    return "levelone"
end

function drawlvl1(dt)
    print("draw")
    tile_x = 0
    tile_y = 300
    for i=138,0,-1 do
        if math.mod(i,9) == 0 or math.mod(i,4) == 0 then
            love.graphics.draw(grass_tile, tile_x, tile_y)
        else
            love.graphics.draw(clover_tile, tile_x, tile_y)
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
                    open = true
                end
            end
        end
    end
    
    button(button1)
    button(button2)
    button(button3)
    button(button4)
    
    if open == true then
        cave.img = love.graphics.newImage('assets/tiles/caveopen.png')
    end
    
    love.graphics.draw(cave.img, cave.x, cave.y)
    love.graphics.draw(background, cave.x-300, cave.y)
    love.graphics.draw(background, cave.x-600, cave.y)
    love.graphics.draw(background, cave.x+300, cave.y)
    love.graphics.draw(background, cave.x+600, cave.y)
    love.graphics.draw(player.img, player.x, player.y)
    
    for i=1, #blocks do
        local b = blocks[i]
        love.graphics.draw(blockimg, b.x, b.y)
    end
end

function button(b)
    if b.count == b.delay then
        b.pressed = false 
        order = {}
    end
    if b.pressed == true then
        b.count = b.count + 1
        love.graphics.draw(button_down, b.x, b.y)
    end
    if player.x > b.x-23 and player.x < (b.x+100)-23 and (player.y+player.h) > b.y and (player.y+player.h) < b.y+100 then
        b.pressed = true
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

function clear
    
end
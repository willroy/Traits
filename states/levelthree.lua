local bump = require 'lib/bump'

local world
local player
local blocks = {}

local function addBlock(x, y)
    local block = {x=x,y=y}
    blocks[#blocks + 1] = block
    world:add(block,x,y,153,40)
end

function enteredStatelvl3()
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
    
    player.img = love.graphics.newImage('assets/character/cf1.png')
    grass_tile = love.graphics.newImage('assets/tiles/tile1new.png')
    buttercup_tile = love.graphics.newImage('assets/tiles/buttercuptile.png')
    clover_tile = love.graphics.newImage('assets/tiles/clovertile.png')
    vines = love.graphics.newImage('assets/tiles/vines.png')
    mask = love.graphics.newImage('assets/tiles/mask.png')
    note1img = love.graphics.newImage('assets/interactable/fillernote.png')
    note1imgdown = love.graphics.newImage('assets/interactable/fillernoteDOWN.png')
    
    
    love.mouse.setVisible(true)
    world = bump.newWorld()
    right_x = 1260
    left_x = 0
    top_y = 0
    bot_y = 960
    
    world:add(player, player.x, player.y, player.w, player.h)
end

function updatelvl3(dt)
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
    return "levelthree"
end

function drawlvl3(dt)
    for a=13,0,-1 do
        love.graphics.draw(vines, tile_x, tile_y)
    end 
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

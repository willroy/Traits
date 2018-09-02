local bump = require 'lib/bump'

local world
local player
local blocks = {}
local Levelone = Game:addState('Levelone')

local function addBlock(x, y)
    local block = {x=x,y=y}
    blocks[#blocks + 1] = block
    world:add(block,x,y,153,40)
end

function Levelone:enteredState()
    right_x = 1260
    left_x = 0
    top_y = 0
    bot_y = 960
    player = {
        x = 460,
        y = 460,
        w = 40,
        h = 40,
        dir = "right",
        speed = 0,
        acc = 1,
        img = nil
    }
    
    house1 = {
        x = 700,
        y = 200,
        c_x = 700,
        c_y = 270,
        w = 300,
        h = 320,
        c_w = 300,
        c_h = 190,
        r_h = 72,
        img_body = nil,
        img_roof = nil
    }
    
    player.img = love.graphics.newImage('assets/MC/character.png')
    blockimg = love.graphics.newImage('assets/platforms/platformgrass.png')
    house1.img_body = love.graphics.newImage('assets/houses/house1/h1body.png')
    house1.img_roof = love.graphics.newImage('assets/houses/house1/h1roof.png')
    grass_tile = love.graphics.newImage('assets/tiles/grass_tile1.png')
    
    love.mouse.setVisible(false)
    world = bump.newWorld()
    
    --addBlock(250, 200)
    world:add(house1.img_body, house1.c_x, house1.c_y, house1.c_w, house1.c_h)
    world:add(player, player.x, player.y, player.w, player.h)
end

function Levelone:update(dt)
    local future_x, future_y = player.x, player.y
    player.speed = 6
    if love.keyboard.isDown("right", "d") and player.x < right_x then
        player.x = player.x + player.speed 
    end
    if love.keyboard.isDown("left", "a") and player.x > left_x then
        player.x = player.x - player.speed 
    end
    if love.keyboard.isDown("up", "w") and player.y > top_y then
        player.y = player.y - player.speed 
    end
    if love.keyboard.isDown("down", "s") and player.y < bot_y then 
        player.y = player.y + player.speed 
    end 
    
    local newX, newY, cols, len = world:move(player, player.x, player.y)
    player.x, player.y = newX, newY
end

function Levelone:draw(dt)
    tile_x = 0
    tile_y = 0
    for i=138,0,-1 do
        love.graphics.draw(grass_tile, tile_x, tile_y)
        tile_x = tile_x + 100
        if tile_x > 1300 then
            tile_y = tile_y + 100
            tile_x = 0
        end
    end
    
    love.graphics.draw(house1.img_body, house1.x, house1.y + house1.r_h)
    love.graphics.draw(player.img, player.x, player.y)
    love.graphics.draw(house1.img_roof, house1.x, house1.y)
    
    for i=1, #blocks do
        local b = blocks[i]
        love.graphics.draw(blockimg, b.x, b.y)
    end
end

function Levelone:keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
    if key == "x" then
        print("x: "..player.x)
        print("y: "..player.y)
    end
end

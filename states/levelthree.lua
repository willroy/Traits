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
--    house1 = {
--        x = 703,
--        y = 240,
--        w = 294,
--        h = 248,
--        c_w = 300,
--        c_h = 248,
--        r_h = 72,
--        img_body = nil,
--        img_roof = nil
--        }
--    note1 = {
--        x = 10, 
--        y = 500, 
--        delay = 100, 
--        pressed = false, 
--        count = 0,
--        id = 1
--    } 
    
    player.img = love.graphics.newImage('assets/character/cf1.png')
    grass_tile = love.graphics.newImage('assets/tiles/tile1new.png')
    buttercup_tile = love.graphics.newImage('assets/tiles/buttercuptile.png')
    clover_tile = love.graphics.newImage('assets/tiles/clovertile.png')
    --house1.img_body = love.graphics.newImage('assets/houses/house1/h1body.png')
    --house1.img_roof = love.graphics.newImage('assets/houses/house1/h1roof.png')
    vines = love.graphics.newImage('assets/tiles/vines.png')
    mask = love.graphics.newImage('assets/tiles/mask.png')
    note1img = love.graphics.newImage('assets/interactable/fillernote.png')
    note1imgdown = love.graphics.newImage('assets/interactable/fillernoteDOWN.png')
    
    --house1.c_h = house1.c_h - (player.h) 
    
    love.mouse.setVisible(true)
    world = bump.newWorld()
    right_x = 1260
    left_x = 0
    top_y = 0
    bot_y = 960
    
    --world:add(house1.img_body, house1.x, house1.y+house1.r_h, house1.c_w, house1.c_h)
    --world:add(vines, 0, 0, 10000, 300-player.h)
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
    return "leveltwo"
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

   -- notepress(note1)

    love.graphics.draw(house1.img_body, house1.x, house1.y+house1.r_h)
    love.graphics.draw(player.img, player.x, player.y)
    love.graphics.draw(house1.img_roof, house1.x, house1.y)
    for i=1, #blocks do
        local b = blocks[i]
        love.graphics.draw(blockimg, b.x, b.y)
    end
--    maskx = 0
--    masky = 0
--    for a=1000,0,-1 do
--        love.graphics.draw(mask, maskx, masky)
--        maskx = maskx + 300
--        if maskx == 1500 then
--            masky = masky + 300
--        end
--    end 
end

--function notepress(n)
--    if n.count == n.delay then
--        n.pressed = false 
--    end
--    if n.pressed == true then
--        n.count = n.count + 1
--        love.graphics.draw(note1imgdown, n.x, n.y)
--    end
--    if player.x > n.x-23 and player.x < (n.x+100)-23 and (player.y+player.h) > n.y and (player.y+player.h) < n.y+100 then
--        n.pressed = true
--        n.count = 0
--        love.graphics.draw(note1img, n.x, n.y) 
--    elseif n.pressed == true then
--        n.count = n.count + 1
--        love.graphics.draw(note1img, n.x, n.y)
--    else
--        n.count = 0
--        love.graphics.draw(note1img, n.x, n.y)
--    end
--end

function keypressedlvl3(key)
    if key == "escape" then
        love.event.push("quit")
    end
    if key == "x" then
        print("x: "..player.x)
        print("y: "..player.y)
    end
end

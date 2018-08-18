local bump = require 'lib/bump'
local world
local player
local platform 

function love.load()
    platform = {
        x = 300,
        y = 300,
        width = 153,
        height = 40,
        w = 153,
        h = 40,
        img = nil
    } 
    player = {
        x = 460,
        y = 460,
        w = 40,
        h = 40,
        dir = "right",
        speed = 130,
        img = nil
    }
    world = bump.newWorld()
    player.img = love.graphics.newImage('assets/MC/character.png')
    platform.img = love.graphics.newImage('assets/platforms/platformgrass.png')
    
    world:add(player, player.x, player.y, player.w, player.h)
    world:add(platform, platform.x, platform.y, platform.w, platform.h)
end

function love.update(dt)
    local future_x, future_y = player.x, player.y
    player.speed = 200
    if love.keyboard.isDown("right", "d") and player.x < 760 then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("left", "a") and player.x > 0 then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("up", "w") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("down", "s") then 
        player.y = player.y + player.speed * dt
    end  
    local newX, newY, cols, len = world:move(player, player.x, player.y)
    player.x, player.y = newX, newY
end

function love.draw(dt)
    love.graphics.draw(player.img, player.x, player.y)
    love.graphics.draw(platform.img, platform.x, platform.y)
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
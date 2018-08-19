local bump = require 'lib/bump'

local world
local player
local blocks = {}
local Levelone = Game:addState('Levelone')

local function DeepPrint (e)
    if type(e) == "table" then
        for k,v in pairs(e) do
            print(k)
            DeepPrint(v)       
        end
    else
        print(e)
    end
end

local function addBlock(x, y)
    local block = {x=x,y=y}
    blocks[#blocks + 1] = block
    world:add(block,x,y,153,40)
end

function Levelone:enteredState()
    love.mouse.setVisible(false)
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
    blockimg = love.graphics.newImage('assets/platforms/platformgrass.png')
    addBlock(300, 300)
    addBlock(400, 400)
    addBlock(300, 100)
    
    world:add(player, player.x, player.y, player.w, player.h)
end

function Levelone:update(dt)
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

function Levelone:draw(dt)
    love.graphics.draw(player.img, player.x, player.y)
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

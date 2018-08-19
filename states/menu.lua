local Menu = Game:addState('Menu')

function Menu:enteredState()
    
end

function Menu:update(dt)
    x, y = love.mouse.getPosition()
    local hover = false
    
    if x > 300 then
        if x < 500 then
            if y > 300 then
                if y < 400 then
                    hover = true
                end  
            end
        end
    end
    if hover then
        if love.mouse.isDown(1) then
            self:gotoState('Levelone')
        end
    end
end

function Menu:draw(dt)
    love.graphics.rectangle('fill', 300, 300, 200, 100)
end

function Menu:keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
    if key == "x" then
        print(love.mouse.getPosition())
    end
end

local Selection = Game:addState('Selection')

function Selection:enteredState()
    love.window.setMode(1300, 1000)
end

function Selection:update(dt)
    x, y = love.mouse.getPosition()
    local hover1 = false
    
    
     if x > 100 then
         if x < 300 then
             if y > 100 then
                 if y < 300 then
                     hover1 = true
                 end  
             end
         end
     end
     print(hover1)
     down = false
     down = love.mouse.isDown(1)
     if hover1 then
         if down then
             self:gotoState('Levelone')
         end
     end

    --love.graphics.setBackgroundColor(178,34,34)
end

function Selection:draw(dt)
    
    love.graphics.setColor(178,34,34,100)
    love.graphics.rectangle('fill', 100, 100, 200, 200)
    love.graphics.setColor(0,0,0) 
    
end

function Selection:keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
    if key == "x" then
        print(love.mouse.getPosition())
    end
end

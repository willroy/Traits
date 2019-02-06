function updatemenu(dt)
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
            return "levelone"
        end
    end
    return "menu"
end

function drawmenu(dt)
    love.graphics.rectangle('fill', 300, 300, 200, 100)
end


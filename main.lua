require 'states/menu'
require 'states/levelone'
require 'states/leveltwo'

function love.load()
    love.window.setMode(1300, 1000)
    enteredStatelvl2()
    state = "leveltwo"
end

function love.update(dt)
    if state == "menu" then
        state = updatemenu()
        if state == "levelone" then
            enteredStatelvl1()
        end
    end
    if state == "levelone" then
        state = updatelvl1(dt)
        if state == "leveltwo" then
            enteredStatelvl2()
        end
    end
    if state == "leveltwo" then
        state = updatelvl2(dt)
    end
end

function love.draw()
    print(state)
    if state == "menu" then
        print("drawing menu")
        drawmenu()
    end
    if state == "levelone" then
        drawlvl1(dt)
    end
    if state == "leveltwo" then
        drawlvl2(dt)
    end
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.push("quit")
    end
    if key == "x" then
        print("x: "..player.x)
        print("y: "..player.y)
    end
    if key == "y" then
        print(love.mouse.getPosition())
    end
end

function love.mousepressed(x, y, button, isTouch)
end

function love.focus(f)
    if not f then
        print("LOST FOCUS")
    else
        print("GAINED FOCUS")
    end
end
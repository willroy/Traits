--Require all the code for the different states (levels, menu, results)
require 'states/menu'
require 'states/levelone'
require 'states/leveltwo'
require 'states/levelthree'
require 'states/results'

--When the game is first launched
function love.load()
  --set the window size
  love.window.setMode(1300, 1000)
  --run the entered state function for the menu state
  enteredStatemenu()
  --state variable to keep track of state
  state = "menu"
  --keep track of time taken for each level
  countlvl1 = 0
  countlvl2 = 0
  countlvl3 = 0
end

--update loop for love 2d (runs every tick before draw function)
function love.update(dt)
  --check what state state variable is
  if state == "menu" then
    state = updatemenu()
    --at end of last update loop for a state, run the entered state function
    --for the next state.
    if state == "levelone" then
      enteredStatelvl1()
    end
  end
  if state == "levelone" then
    --countlvl for a level is updated every update loop 
    state, countlvl1 = updatelvl1(dt)
    if state == "leveltwo" then
      enteredStatelvl2()
    end
  end
  if state == "leveltwo" then
    state, countlvl2 = updatelvl2(dt)
    if state == "levelthree" then
      enteredStatelvl3()
    end
  end
  if state == "levelthree" then
    state, countlvl3 = updatelvl3(dt)
    if state == "results" then
      enteredStateresults(countlvl1, countlvl2, countlvl3)
    end
  end
end

--draw function, to run each state's draw function every tick after update
function love.draw()
  if state == "menu" then
    --e.g drawmenu function if state is menu
    drawmenu()
  end
  if state == "levelone" then
    drawlvl1(dt)
  end
  if state == "leveltwo" then
    drawlvl2(dt)
  end
  if state == "levelthree" then
    drawlvl3(dt)
  end
  if state == "results" then
    drawresults(dt)
  end
end

--if a key is pressed this function will run
function love.keypressed(key, code)
  --key is the keycode of the key pressed on the keyboard
  if key == "escape" then
    --if the key is escape, then trigger a quit event (closes game)
    love.event.push("quit")
  end
  if key == "x" then
    --if the key is x, then the x and y coordinate of the player is printed to
    --the console
    print("x: "..player.x)
    print("y: "..player.y)
  end
  if key == "y" then
    --if the key is y, the the mouse position is printed to console
    print(love.mouse.getPosition())
  end
end

-- if the mouse is pressed this function will run
function love.mousepressed(x, y, button, isTouch)
end

function love.focus(f)
  --prints lost focus if the user is not focused on the window.
  if not f then
    print("LOST FOCUS")
  else
    print("GAINED FOCUS")
  end
end

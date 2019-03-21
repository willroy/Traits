--entered state function to load images and set other things
function enteredStatemenu()
  --load the start button image
  start = love.graphics.newImage('assets/BUTTON/BUTTON_start.png')
  --set the background colour to white
  love.graphics.setBackgroundColor(100,100,100)
end

function updatemenu(dt)
  --x and y is the location of the mouse
  x, y = love.mouse.getPosition()
  local hover = false

  --if the mouse is above the button, then the mouse is hovering over the
  --button
  if x > 300 then
    if x < 500 then
      if y > 300 then
        if y < 400 then
          hover = true
        end  
      end
    end
  end
  --if the mouse is over the button then test whether the mouse button is down
  if hover then
    if love.mouse.isDown(1) then
      --go to level one if button is clicked
      return "levelone"
    end
  end
  --if not clicked on button just return menu state
  return "menu"
end

--draw the start button at 500 500 xy coordinate
function drawmenu(dt)
  love.graphics.draw(start, 500, 500)
end


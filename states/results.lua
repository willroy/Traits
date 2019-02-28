function enteredStateresults(countlvl1, countlvl2, countlvl3)
  results = love.graphics.newImage('assets/TEXT/TEXT_Results.png')
  vis = love.graphics.newImage('assets/TEXT/TEXT_Visual.png')
  aud = love.graphics.newImage('assets/TEXT/TEXT_Auditory.png')
  kin = love.graphics.newImage('assets/TEXT/TEXT_Kin.png')
  one = love.graphics.newImage('assets/TEXT/TEXT_One.png')
  love.graphics.setBackgroundColor(100,100,100)
  medium = love.graphics.newFont(45)
end

function updateresults(dt)
end

function drawresults(dt)
  love.graphics.setColor(255,255,255)
  if countlvl1 < countlvl2 and countlvl1 < countlvl3 then
    love.graphics.draw(one, 530, 270)
  end
  if countlvl2 < countlvl1 and countlvl2 < countlvl3 then
    love.graphics.draw(one, 530, 470)
  end
  if countlvl3 < countlvl2 and countlvl3 < countlvl1 then
    love.graphics.draw(one, 530, 670)
  end
  love.graphics.draw(results, 650, 100)
  love.graphics.draw(vis, 650, 300)
  love.graphics.draw(aud, 650, 500)
  love.graphics.draw(kin, 650, 700)

  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(medium)

  love.graphics.print(tostring(countlvl1), 400, 300)
  love.graphics.print(tostring(countlvl2), 400, 500)
  love.graphics.print(tostring(countlvl3), 400, 700)
end


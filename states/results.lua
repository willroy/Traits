function enteredStateresults()
  results = love.graphics.newImage('assets/TEXT/TEXT_Results.png')
  vis = love.graphics.newImage('assets/TEXT/TEXT_Visual.png')
  aud = love.graphics.newImage('assets/TEXT/TEXT_Auditory.png')
  kin = love.graphics.newImage('assets/TEXT/TEXT_Kin.png')
  love.graphics.setBackgroundColor(100,100,100)
end

function updateresults(dt)
end

function drawresults(dt)
  love.graphics.draw(results, 650, 100)
  love.graphics.draw(vis, 650, 300)
  love.graphics.draw(aud, 650, 500)
  love.graphics.draw(kin, 650, 700)
end


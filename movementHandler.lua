function movementHandler(dt)
   if love.keyboard.isDown("up") then
      yplane = yplane - speed*dt
      headingplane=0
   elseif love.keyboard.isDown("down") then
      yplane = yplane + speed*dt
      headingplane=math.rad(180)
   elseif love.keyboard.isDown("right") then
      xplane = xplane + 100*dt
      headingplane=math.rad(90)
   elseif love.keyboard.isDown("left") then
      xplane = xplane - 100*dt
      headingplane=math.rad(270)
   end
end
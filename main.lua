function love.load()
   love.graphics.setBackgroundColor(255,255,255)
   plane=love.graphics.newImage("sprites/planesmall.gif")
   xplane=300
   yplane=300
   width=plane:getWidth()
   height =plane:getHeight()
   headingplane=0
end

function love.draw()

   love.graphics.draw(plane,xplane,yplane,headingplane,1,1,width/2,height/2)
end

function love.update(dt)
   if love.keyboard.isDown("up") and love.keyboard.isDown("left")  then
      yplane = yplane - 71.1*dt
      xplane = xplane - 71.1*dt
      headingplane=math.rad(315)
   elseif love.keyboard.isDown("up") and love.keyboard.isDown("right")  then
      yplane = yplane - 71.1*dt
      xplane = xplane + 71.1*dt
      headingplane=math.rad(45)
   elseif love.keyboard.isDown("down") and love.keyboard.isDown("left")  then
      yplane = yplane + 71.1*dt
      xplane = xplane - 71.1*dt
      headingplane=math.rad(225)
   elseif love.keyboard.isDown("down") and love.keyboard.isDown("right")  then
      yplane = yplane + 71.1*dt
      xplane = xplane + 71.1*dt
      headingplane=math.rad(135)
   elseif love.keyboard.isDown("up") then
      yplane = yplane - 100*dt
      headingplane=0
   elseif love.keyboard.isDown("down") then
      yplane = yplane + 100*dt
      headingplane=math.rad(180)
   elseif love.keyboard.isDown("right") then
      xplane = xplane + 100*dt
      headingplane=math.rad(90)
   elseif love.keyboard.isDown("left") then
      xplane = xplane - 100*dt
      headingplane=math.rad(270)
   end
 
end

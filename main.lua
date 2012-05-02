require('generateworld')

function love.load()
   plane=love.graphics.newImage("sprites/planesmall.gif")
 
   --setup world
   loadtiles()
   world=createworld()




   xplane=300
   yplane=300
   width=plane:getWidth()
   height =plane:getHeight()
   headingplane=0
end

function love.draw()

   drawworld(world)
   love.graphics.draw(plane,xplane,yplane,headingplane,1,1,width/2,height/2)
end

function love.update(dt)

   if love.keyboard.isDown("up") then
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



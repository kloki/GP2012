function movementHandler(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   if u then
      if r then
         ysprite = ysprite - d_speed*dt
         xsprite = xsprite + d_speed*dt
      elseif l then
         ysprite = ysprite - d_speed*dt
         xsprite = xsprite - d_speed*dt
      else
         ysprite = ysprite - speed*dt
      end
   elseif d then
      if r then
         ysprite = ysprite + d_speed*dt
         xsprite = xsprite + d_speed*dt
      elseif l then
         ysprite = ysprite + d_speed*dt
         xsprite = xsprite - d_speed*dt
      else
         ysprite = ysprite + speed*dt
      end
   elseif r then
      xsprite = xsprite + speed*dt
   elseif l then
      xsprite = xsprite - speed*dt
   end
   
   ysprite = math.max(math.min(ysprite,640 - height),0)
   xsprite = math.max(math.min(xsprite,800 - width),0)
end
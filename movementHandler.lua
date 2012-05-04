function movementHandler(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   
   w_height= love.graphics.getHeight()
   w_width = love.graphics.getWidth()
   
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
   
   ysprite = math.max(math.min(ysprite,w_height - tilesize - height_sprite/2),height_sprite/2)
   xsprite = math.max(math.min(xsprite,w_width  - width_sprite/2),width_sprite/2)
end
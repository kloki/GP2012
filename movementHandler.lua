function movementHandler(dt,coor)
   if spressed == false then
      u = love.keyboard.isDown("up")
      d = love.keyboard.isDown("down")
      r = love.keyboard.isDown("right")
      l = love.keyboard.isDown("left")
      local dx,dy = 0,0
      if u then
         if r then
            dy = -d_speed*dt
            dx =  d_speed*dt
         elseif l then
            dy = -d_speed*dt
            dx = -d_speed*dt
         else
            dy = -speed*dt
         end
      elseif d then
         if r then
            dy = d_speed*dt
            dx = d_speed*dt
         elseif l then
            dy =  d_speed*dt
            dx = -d_speed*dt
         else
            dy = speed*dt
         end
      elseif r then
         dx = speed*dt
      elseif l then
         dx = -speed*dt
      end
      
      LinkBB:move(dx,dy)
      xsprite = xsprite + dx
      ysprite = ysprite + dy
   end

end



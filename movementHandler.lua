function movementHandler(dt,coor)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   
   if u then
      if r then
         ysprite = ysprite - d_speed*dt
         xsprite = xsprite + d_speed*dt
      elseif l then
         xsprite = xsprite - d_speed*dt
         ysprite = ysprite - d_speed*dt
      elseif d then
         xsprite = xsprite
         ysprite = ysprite
      else
         ysprite = ysprite - d_speed*dt
      end
   elseif d then
      if r then
         ysprite = ysprite + d_speed*dt
         xsprite = xsprite + d_speed*dt
      elseif l then
         ysprite = ysprite + d_speed*dt
         xsprite = xsprite - d_speed*dt
      elseif u then
         xsprite = xsprite
         ysprite = ysprite
      else
         ysprite = ysprite + d_speed*dt
      end
   elseif r then
      if l then
         xsprite = xsprite
         ysprite = ysprite
      else
         xsprite = xsprite + speed*dt
      end
   elseif l then
      if r then
         xsprite = xsprite
         ysprite = ysprite
      else
         xsprite = xsprite - speed*dt     
      end
   end
   --prevent walking outside of screen
   ysprite = math.max(math.min(ysprite,w_height - 2*tilesize - height_sprite/2),height_sprite/2)
   xsprite = math.max(math.min(xsprite,w_width  - 0.5*tilesize - width_sprite/2),width_sprite/2)

   --walking through gate
   --needs to use globals instead of being hardcoded
   --up
   if ysprite < 50 and overworld[coor[1]-1][coor[2]]~=0 then
      currentworld=overworld[coor[1]-1][coor[2]]
      coor[1]=coor[1]-1
      ysprite=500
   end
   --left
   if xsprite < 50 and overworld[coor[1]][coor[2]-1]~=0 then
      currentworld=overworld[coor[1]][coor[2]-1]
      coor[2]=coor[2]-1
      xsprite=600
   end
   --right
   if xsprite > 750 and overworld[coor[1]][coor[2]+1]~=0 then
      currentworld=overworld[coor[1]][coor[2]+1]
      coor[2]=coor[2]+1
      xsprite=100
   end
   --down
   if ysprite > 540 and overworld[coor[1]+1][coor[2]]~=0 then
      currentworld=overworld[coor[1]+1][coor[2]]
      coor[1]=coor[1]+1
      ysprite=100
   end

end



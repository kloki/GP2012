require ('lAnA')
function loadSprite()
   sheet = love.graphics.newImage("sprites/LinkMC2.gif")

   linkdownS = love.graphics.newQuad(24,12,20,30,720,2630)
   linkleftS = love.graphics.newQuad(24,44,20,30,720,2630)
   linkupS = love.graphics.newQuad(25,80,20,30,720,2630)
   linkleftS:flip(true,false)
   linkrightS = love.graphics.newQuad(24,44,20,30,720,2630)
    
   linkdownRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12,false)
   linkrightRun = newAnimation(sheet,27,32,0.1,10,52,44,false)
   linkupRun = newAnimation(sheet,23,32,0.1,10,61,80,false)
   linkleftRun = newAnimation(sheet,27,32,0.1,10,52,44,true)
   
   linkupSword = newAnimation(sheet,32,38,0.1,8,20,126,false)
   linkdownSword = newAnimation(sheet,32,38,0.1,8,20,126,false)
   linkrightSword = newAnimation(sheet,32,38,0.1,8,20,126,false)
   linkleftSword = newAnimation(sheet,32,38,0.1,8,20,126,false)
   linkupSword:setMode("once")
   --
   sprite = 'standdown'
   heading = 'down'

    
end

function drawSprite()
   --love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
   if sprite == 'moveup' then
      linkupRun:draw(xsprite,ysprite)
   elseif sprite == 'movedown' then
      linkdownRun:draw(xsprite,ysprite)
   elseif sprite == 'moveright' then
      linkrightRun:draw(xsprite,ysprite)
   elseif sprite == 'moveleft' then
      linkleftRun:draw(xsprite,ysprite)

   elseif sprite == 'swordup' then
      linkupSword:draw(xsprite,ysprite)
      linkupSword:play()
   elseif sprite == 'sworddown' then
      linkdownSword:draw(xsprite,ysprite)
   elseif sprite == 'swordright' then
      linkrightSword:draw(xsprite,ysprite)
   elseif sprite == 'swordleft' then
      linkleftSword:draw(xsprite,ysprite)

   elseif sprite == 'standup' then
      love.graphics.drawq(sheet,linkupS,xsprite,ysprite)
   elseif sprite == 'standright' then
      love.graphics.drawq(sheet,linkrightS,xsprite,ysprite)
   elseif sprite == 'standleft' then
      love.graphics.drawq(sheet,linkleftS,xsprite,ysprite)
   elseif sprite == 'standdown' then
      love.graphics.drawq(sheet,linkdownS,xsprite,ysprite)
   end      
end

function updateSprite(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   s = love.keyboard.isDown(" ")
   b = love.keyboard.isDown("lctrl")
   -- hier logica
   --linkupSword:update(dt)]]

   if u then
      linkupRun:update(dt)
      sprite = 'moveup'
      heading = 'up'
   end
   if d then
      linkdownRun:update(dt)
      sprite = 'movedown'
      heading = 'down'
   end
   if r then
      linkrightRun:update(dt)
      sprite = 'moveright'
      heading = 'right'
   end
   if l then
      linkleftRun:update(dt)
      sprite = 'moveleft'
      heading = 'left'
   end
   if (u and r) or (u and l) then
      linkupRun:update(dt)
      sprite = 'moveup'
      heading = 'up'
   end
   if (d and r) or (d and l) then
      linkdownRun:update(dt)
      sprite = 'movedown'
      heading = 'down'
   end
   if u and d then
      sprite = 'standdown'
   end
   if r and l then
      sprite = 'standdown'
   end
   if s then
      if heading == 'down' then
         --linkdownSword:update(dt)
         sprite = 'sworddown'
      elseif heading == 'up' then
         --linkupSword:update(dt)
         sprite = 'swordup'
      elseif heading == 'right' then
         --linkrightSword:update(dt)
         sprite = 'swordright'
      elseif heading == 'left' then
         --linkleftSword:update(dt)
         sprite = 'swordleft'
      end
   end

   if b then
    
   end

   if not d and not u and not r and not l and not s and not b then
      if heading == 'down' then
         sprite = 'standdown'
      elseif heading == 'up' then
         sprite = 'standup'
      elseif heading == 'right' then
         sprite = 'standright'
      elseif heading == 'left' then
         sprite = 'standleft'
      end
   end


end

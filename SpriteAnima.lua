require ('lAnA')
function loadSprite()

   sheet = love.graphics.newImage("sprites/LinkMC1.gif")
   linkfrontS = love.graphics.newQuad(24,12,20,30,720,1024)
   linkleftS = love.graphics.newQuad(24,44,20,30,720,1024)
   linkbackS = love.graphics.newQuad(25,80,20,30,720,1024)
   local x = true
   local y = false
   linkleftS:flip(x,y)
   linkrightS = love.graphics.newQuad(24,44,20,30,720,1024)
    
   linkfrontRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12,false)
   linkrightRun = newAnimation(sheet,27,32,0.1,10,52,44,false)
   linkbackRun = newAnimation(sheet,23,32,0.1,10,61,80,false)
   linkleftRun = newAnimation(sheet,27,32,0.1,10,52,44,true)
    

    
end

function drawSprite()
   --love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
   if move == 'none' then
      if stop == 'up' then
         love.graphics.drawq(sheet,linkbackS,xsprite,ysprite)
      elseif stop == 'right' then
         love.graphics.drawq(sheet,linkrightS,xsprite,ysprite)
      elseif stop == 'left' then
         love.graphics.drawq(sheet,linkleftS,xsprite,ysprite)
      else
         love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
      end
   elseif move == 'right' then
      linkrightRun:draw(xsprite,ysprite)
   elseif move == 'down' then
      linkfrontRun:draw(xsprite,ysprite)
   elseif move == 'up' then
      linkbackRun:draw(xsprite,ysprite)
   elseif move == 'left' then
      linkleftRun:draw(xsprite,ysprite)
   else
      love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
   end   
end

function updateSprite(dt)
   if move == 'down' then
      linkfrontRun:update(dt)
   elseif move == 'right' then
      linkrightRun:update(dt)
   elseif move == 'left' then
      linkleftRun:update(dt)
   elseif move == 'up' then
      linkbackRun:update(dt)
   end
end

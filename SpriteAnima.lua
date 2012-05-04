require ('lAnA')
function loadSprite()
    sheet = love.graphics.newImage("sprites/LinkMC.gif")
    linkfrontS = love.graphics.newQuad(24,12,20,30,720,2630)
    
    linkfrontRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12)
    linksideRun = newAnimation(sheet,27,32,0.1,10,52,44)
    

    
end

function drawSprite()
   --love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
   if move == 'none' then
      love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
   elseif move == 'right' then
      linksideRun:draw(xsprite,ysprite)
   end   
    --[[if move then
        linksideRun:draw(xplane,yplane)
    else
        love.graphics.drawq(sheet,linkfrontS,xplane,yplane)
    end]]
    --love.graphics.drawq(sheet,sp, xplane, yplane)
    --love.graphics.drawq(sheet,linkfrontM[3], 200, 200)
    --love.graphics.drawq(sheet,linkfrontM[4], 100, 100)
    --love.graphics.drawq(sheet,linkfrontM[5], 10, 10)
    --love.graphics.drawq(sheet,linkfrontM[6], 100, 10)
end

function updateSprite(dt)
    --linkfrontRun:update(dt)
    linksideRun:update(dt)
end

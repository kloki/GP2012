function spawnEnemy()
   x_loc = tilesize + math.random() * (love.graphics.getWidth()  - 2*tilesize)
   y_loc = tilesize + math.random() * (love.graphics.getHeight() - 4*tilesize)
   -- remove locations around sprite
end

require ('lAnA')
function loadEnemySprites()
   goron_sheet = love.graphics.newImage("sprites/goron.png")
   goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
    
   --linkfrontRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12)
    

    
end

function drawEnemy()
   love.graphics.drawq(goron_sheet,goronfrontS,x_loc,y_loc)
   --love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
end

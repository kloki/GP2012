require ('lAnA')
function spawnEnemy()
   x_loc = tilesize + math.random() * (love.graphics.getWidth()  - 2*tilesize)
   y_loc = tilesize + math.random() * (love.graphics.getHeight() - 4*tilesize)
   if math.random() > 0.5 then
      facing = 'right'
   else
      facing = 'left'
   end
   -- remove locations around sprite
end

require ('lAnA')
function loadEnemySprites()
   w_goron = 24
   goron_sheet = love.graphics.newImage("sprites/goron.png")
   goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
    
   --linkfrontRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12)
   goronrightRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,false)
   goronleftRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,true)
    
end

function drawEnemy()
   
   if facing == 'right' then
      goronrightRun:draw(x_loc,y_loc)
   elseif facing == 'left' then
      goronleftRun:draw(x_loc,y_loc)
   else
      love.graphics.drawq(goron_sheet,goronfrontS,x_loc,y_loc)
   end
   --love.graphics.drawq(sheet,linkfrontS,xsprite,ysprite)
end

function updateEnemy(dt)
   if facing == 'right' then
      goronrightRun:update(dt)
      x_loc = x_loc + goron_speed * dt
      if x_loc > w_width - tilesize - w_goron then
         facing = 'left'
      end
   elseif facing == 'left' then
      goronleftRun:update(dt)
      x_loc = x_loc - goron_speed * dt
      if x_loc < tilesize + w_goron then
         facing = 'right'
      end
   end
end
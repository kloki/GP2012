require ('lAnA')

Goron = {}
Goron.__index = Goron

function Goron.create()
   local gor = {}             -- our new object
   setmetatable(gor,Goron)  -- make Account handle lookup
   gor.x_loc = tilesize + math.random() * (love.graphics.getWidth()  - 2*tilesize)
   gor.y_loc = tilesize + math.random() * (love.graphics.getHeight() - 4*tilesize)
   if math.random() > 0.5 then
      gor.facing = 'right'
   else
      gor.facing = 'left'
   end      -- initialize object
   
   --TODO move this to out so not every goron has to load this stuff
   function gor:loadSprites()
      w_goron = 24
      goron_sheet = love.graphics.newImage("sprites/goron.png")
      gor.goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
       
      gor.goronrightRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,false)
      gor.goronleftRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,true)
   end
   
   function gor:draw()
      if gor.facing == 'right' then
         gor.goronrightRun:draw(gor.x_loc,gor.y_loc)
      elseif gor.facing == 'left' then
         gor.goronleftRun:draw(gor.x_loc,gor.y_loc)
      else
         love.graphics.drawq(goron_sheet,goronfrontS,gor.x_loc,gor.y_loc)
      end
   end
   
   function gor:update(dt)
      if gor.facing == 'right' then
         gor.goronrightRun:update(dt)
         gor.x_loc = gor.x_loc + goron_speed * dt
         if gor.x_loc > w_width - tilesize - w_goron then
            gor.facing = 'left'
         end
      elseif gor.facing == 'left' then
         gor.goronleftRun:update(dt)
         gor.x_loc = gor.x_loc - goron_speed * dt
         if gor.x_loc < tilesize + w_goron then
            gor.facing = 'right'
         end
      end
   end
   
   return gor
end







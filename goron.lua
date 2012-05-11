require ('lAnA')

Goron = {}
Goron.__index = Goron

function Goron.create(id)
   local gor = {}             -- our new object
   setmetatable(gor,Goron)  -- make Account handle lookup
   --TODO handle possibility off gorons spawning at the same place
   gor.ID = id
   gor.x = tilesize + math.random() * (love.graphics.getWidth()  - 2*tilesize)
   gor.y = tilesize + math.random() * (love.graphics.getHeight() - 4*tilesize)
   if math.random() > 0.5 then
      gor.facing = 'right'
   else
      gor.facing = 'left'
   end      -- initialize object
   --gor.facing = 'up'
   
   --TODO move this to out so not every goron has to load this stuff
   function gor:loadSprites()
      w_goron = 24
      h_goron = 30
      goron_sheet = love.graphics.newImage("sprites/goron.png")
      gor.goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
       
      gor.goronrightRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,false)
      gor.goronleftRun = newAnimation(goron_sheet,w_goron,30,0.1,8,92,158,true)
	   gor.goronupRun = newAnimation(goron_sheet,30.5,30,0.15,7,83,89,false)
   end
   
   function gor:draw()
      if gor.facing == 'right' then
         gor.goronrightRun:draw(gor.x,gor.y)
      elseif gor.facing == 'left' then
         gor.goronleftRun:draw(gor.x,gor.y)
	  elseif gor.facing == 'up' then
	     gor.goronupRun:draw(gor.x,gor.y)
      elseif gor.facing == 'down' then
		 --replace this later with the correct animation
         love.graphics.drawq(goron_sheet,gor.goronfrontS,gor.x,gor.y)
	  else
		 love.graphics.drawq(goron_sheet,gor.goronfrontS,gor.x,gor.y)
      end
   end
   
   function gor:update(dt)
      --calculate position update
      if     gor.facing == 'right' then gor.x = gor.x + goron_speed * dt
      elseif gor.facing == 'left'  then gor.x = gor.x - goron_speed * dt
      elseif gor.facing == 'up'    then gor.y = gor.y - goron_speed * dt
      elseif gor.facing == 'down'  then gor.y = gor.y + goron_speed * dt
      end
	  
	  --update movement animation
	   if gor.facing == 'right' then
         gor.goronrightRun:update(dt)
	   elseif gor.facing == 'left' then
         gor.goronleftRun:update(dt)
	   elseif gor.facing == 'up' then
         gor.goronupRun:update(dt)
	   end
   end
   
   function gor:bounce(other_dir)
      local dir = other_dir
      if     dir == 'right' then gor.facing = 'left'
      elseif dir == 'left' then gor.facing = 'right'
      elseif dir == 'up' then gor.facing = 'down'
      elseif dir == 'down' then gor.facing = 'up'
      else error("invalid input") end
   end
   
   function gor:turn(dir)
      local dir
      moves = {'right','left','up','down'}
      output = dir
      table.removekey(moves,dir)
      gor.facing = table.random(moves,table.size(moves))
   end
   
   function gor:getPosition()
      return gor.x, gor.y, w_goron, h_goron
   end
   
   function gor:collision()
	  return true
   end
   
   function gor:getID()
      return gor.ID
   end
   
   function gor:getFacing()
      return gor.facing
   end
   
   return gor
end

function table.removekey(table, key)
    for i,v in ipairs(table) do
      if table[i] == key then table[i] = nil end
    end
end

function table.exists(table, key)
	if table[key] == nil then
	   return false
	else
	   return true
	end
end

function table.size(table)
   local num = 0
   for _,_ in ipairs(table) do
      num = num+1
   end
   return num
end

function table.random(table,length)
	pick = math.random(length)
	for i,v in ipairs(table) do
		if i == pick then
			return v
		end
	end
	return nil
end

function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end



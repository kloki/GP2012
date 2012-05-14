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
   gor.w = 24
   gor.h = 30
   if math.random() > 0.5 then
      gor.facing = 'right'
   else
      gor.facing = 'left'
   end      -- initialize object
   goron_bb[id] = Collider:addRectangle(gor.x,gor.y,gor.w,gor.h)
   
   
   --TODO move this to out so not every goron has to load this stuff
   function gor:loadSprites()
      goron_sheet = love.graphics.newImage("sprites/goron.png")
      gor.goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
       
      gor.goronrightRun = newAnimation(goron_sheet,24,30,0.1,8,92,158,false)
      gor.goronleftRun = newAnimation(goron_sheet,24,30,0.1,8,92,158,true)
	   gor.goronupRun = newAnimation(goron_sheet,30.5,30,0.15,7,83,89,false)
   end
   
   gor.loadSprites()
   
   function gor:draw()
      if gor.facing == 'right' then
         gor.goronrightRun:draw(gor.x-0.5*gor.w,gor.y-0.5*gor.h)
      elseif gor.facing == 'left' then
         gor.goronleftRun:draw(gor.x-0.5*gor.w,gor.y-0.5*gor.h)
	  elseif gor.facing == 'up' then
	     gor.goronupRun:draw(gor.x-0.5*gor.w,gor.y-0.5*gor.h)
      elseif gor.facing == 'down' then
		 --replace this later with the correct animation
         love.graphics.drawq(goron_sheet,gor.goronfrontS,gor.x-0.5*gor.w,gor.y-0.5*gor.h)
	  else
		 love.graphics.drawq(goron_sheet,gor.goronfrontS,gor.x-0.5*gor.w,gor.y-0.5*gor.h)
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
   
   function gor:move(dx,dy)
      gor.x = gor.x + dx
      gor.y = gor.y + dy
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
      return gor.x, gor.y, gor.w, gor.h
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

function spawnGorons()
   gorons = {}
   for i,v in ipairs(goron_bb) do
      Collider:remove(v)
   end
   for i=1,number_of_gorons do
      table.insert(gorons, Goron.create(i))
   end
end
function addObjects()
	Object = {}
	Portal = {}
	Directions = {'North','East','South','West'}
	if Objects[currentworld] ~= nil then
		for i,v in ipairs(Objects[currentworld]) do
			if v[5] == 'Object' then
				Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
				Object[#Object].Type = 'Object'
				Collider:addToGroup("Object",Object[#Object])
			elseif v[5]=='Key56' or v[5]=='Key57' or v[5]=='Key58' or v[5]=='Key59' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Key'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].key=v[5]
			   Object[#Object].location={v[1],v[2]}
			elseif v[5]=='Heart' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Heart'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			elseif v[5]=='Gate' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Gate'
			   Object[#Object].KeyType = v[6]
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			elseif v[5]=='Door' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Door'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			elseif v[5]=='Door2' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Door2'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			   Object[#Object].returnlocation={v[6],v[7]}
			elseif v[5]=='Chest' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Chest'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}	
			elseif v[5]=='bettersword' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'bettersword'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			elseif v[5]=='boomerangitem' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'boomerangitem'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}		
			elseif v[5]=='OpenChest' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'OpenChest'
			   Collider:addToGroup("Object",Object[#Object])
			   Object[#Object].location={v[1],v[2]}
			else 
			   Portal[v[5]] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Portal[v[5]].Type = 'Portal'
			   Collider:addToGroup("Object",Portal[side])
			   for i=1,#Directions do
			      if     v[5] == 'North' then Portal[v[5]].ix,Portal[v[5]].iy = 0,-1
			      elseif v[5] == 'East'  then Portal[v[5]].ix,Portal[v[5]].iy = 1,0
			      elseif v[5] == 'South' then Portal[v[5]].ix,Portal[v[5]].iy = 0,1
			      elseif v[5] == 'West'  then Portal[v[5]].ix,Portal[v[5]].iy = -1,0 end
			   end
			end
		end
	end
end

function removeObjects()
	for i=1,#Object do Collider:remove(Object[i]) end
	for k,v in pairs(Portal) do Collider:remove(v) end
   for  i=1,#Rupee do Collider:remove(Rupee[i]) end
   Rupee = {}
end

function deleteObject(object,location)
   
   removing=0
   for i,v in ipairs(Objects[currentworld]) do 
      if v[5]==object and v[1]==location[1] and v[2]==location[2] then removing=i break end      
   end
   table.remove( Objects[currentworld],removing)

   --reset everything
   removeObjects()
   addObjects()
end

function modifyObject(object,location,newobject)
   changing=0
   for i,v in ipairs(Objects[currentworld]) do 
      if v[5]==object and v[1]==location[1] and v[2]==location[2] then changing=i break end      
   end
   Objects[currentworld][changing][5]=newobject

   --reset everything
   removeObjects()
   addObjects()

end

function addLink(x,y,w,h)
	Link = Collider:addRectangle(x,y,w,h)

   Link.Type = 'Link'
   Link.hit = 0
	Link.color = {255,255,255}
	Collider:addToGroup("Link",Link)
end

function updateLink(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   local dx,dy = 0,0
   if spressed or cpressed then
   else
      
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
   end
      
   Link:move(dx,dy)
   if Link.hit > 0 then 
		Link.hit = Link.hit -1*dt
		if math.cos(Link.hit*(1/0.1)*3.14) > 0 then
			Link.color = {255,0,0}
		else
			Link.color = {255,255,255}
		end
	else
		Link.color = {255,255,255}
	end
end

function addFoes()
   Foes = {}
   local foe_type, foe_num
   if currentworld < numberofworlds then
      if currentworld%3==0 then foe_type = 'crow'
      elseif currentworld%3==1 then foe_type = 'goron'
      elseif currentworld%3==2 then foe_type = 'snake' end
      if currentworld < 10 then foe_num = 6
      elseif currentworld < 20 then foe_num = 8
      else foe_num = 10 end
      for i=1,foe_num do addFoe(Spawnpoints[1][i][1]*tilesize,Spawnpoints[1][i][2]*tilesize,foe_type) end
   end
end

function addFoe(x,y,foetype)
   if foetype == 'goron' then
      Foes[#Foes + 1] = Collider:addRectangle(x,y,24,30)
      Foes[#Foes].dir = {0,-1} --vector for direction the Foe is facing (x,y)
      Foes[#Foes].speed = 30
      Foes[#Foes].sprite = 'goron'
      Foes[#Foes].life = 4
   elseif foetype == 'snake' then
      Foes[#Foes + 1] = Collider:addRectangle(x,y,20,24)
      Foes[#Foes].dir = {0,1} --vector for direction the Foe is facing (x,y)
      Foes[#Foes].speed = 40
      Foes[#Foes].sprite = 'snake'
      Foes[#Foes].life = 3
   elseif foetype == 'crow' then
      Foes[#Foes+1] = Collider:addRectangle(x,y,20,18)
      Foes[#Foes].dir = {1,0}
      Foes[#Foes].speed = 60
      Foes[#Foes].sprite = 'crow'
      Foes[#Foes].life = 2
      --randomly give the crow a color
      if math.random() > 0.5 then Foes[#Foes].col = 'red' else Foes[#Foes].col = 'blue' end
   end
   Foes[#Foes].alert = false 
   Foes[#Foes].hit = 0
   Foes[#Foes].color = {255,255,255}
   Foes[#Foes].Type = 'Foe'
   Foes[#Foes].turnprob = 0 --probability of turning on a given moment initialized on zero
end

function removeFoes()
   for k,v in ipairs(Foes) do Collider:remove(v) end
end

function addSword()
	Sword = Collider:addRectangle(0,0,24,24)
	Sword.Type = 'Sword'
	Collider:addToGroup('Link',Sword)
	Collider:setGhost(Sword)
end

function sword()
	if spressed then
		local x,y = Link:bbox()
		if     Link.heading == 'down' then Sword:moveTo(x+12,y+45)
		elseif Link.heading == 'up'   then Sword:moveTo(x+12,y-9)
		elseif Link.heading == 'right'then Sword:moveTo(x+36,y+15)
		elseif Link.heading == 'left' then Sword:moveTo(x-12,y+15)
		end
		Collider:setSolid(Sword)
	else
		Collider:setGhost(Sword)
	end
end

function addRupee(x,y,color)
	Rupee[#Rupee+1] = Collider:addRectangle(x,y,16,20)
	Rupee[#Rupee].Type = 'Rupee'
   Rupee[#Rupee].color = color
   if     color == 'red'   then Rupee[#Rupee].value = 20 
   elseif color == 'blue'  then Rupee[#Rupee].value = 5
   elseif color == 'green' then Rupee[#Rupee].value = 1 end
	Rupee[#Rupee].exist = true
	Rupee[#Rupee].x, Rupee[#Rupee].y = x,y
	Collider:addToGroup('Object',Rupee[#Rupee])
end

function addBoomerang()
	Boomerang = Collider:addRectangle(0,0,20,20)
	Boomerang.Type = 'Boomerang'
   Boomerang.speed = 80
   Boomerang.timer = 0
   Boomerang.life = 6
	Collider:addToGroup('Link',Boomerang)
	Collider:setGhost(Boomerang)
end

function initBoomerang()
   if     Link.heading == 'up'    then Boomerang.dir = {0,-1}
   elseif Link.heading == 'down'  then Boomerang.dir = {0,1}
   elseif Link.heading == 'left'  then Boomerang.dir = {-1,0}
   elseif Link.heading == 'right' then Boomerang.dir = {1,0} end
   local x,y = Link:bbox()
   Boomerang.x = x
   Boomerang.y = y
   Boomerang.active = true
   Boomerang.timer = 0
   Boomerang.life = 6
   Boomerang:moveTo(Boomerang.x,Boomerang.y)
   Collider:setSolid(Boomerang)
end

function removeBoomerang()
   Boomerang.active = false
   Collider:setGhost(Boomerang)
end
--[[
function addBoem()
   Boem = Collider:addRectangle(0,0,15,15)
   Boem.Type = 'Boem'
   Collider:addToGroup('Link',Boem)
   Collider:setGhost(Boem)
end

function boem()
   if cpressed then
      local x,y Link:bbox()
		if     Link.heading == 'down' then Sword:moveTo(x+12,y+45)
		elseif Link.heading == 'up'   then Sword:moveTo(x+12,y-9)
		elseif Link.heading == 'right'then Sword:moveTo(x+36,y+15)
		elseif Link.heading == 'left' then Sword:moveTo(x-12,y+15)
      end
      Collider:setSolid(Boem)
   else
      Collider:setGhost(Boem)
   end
end

function updateBoem(dt)
end]]



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
			elseif v[5]=='Chest' then
			   Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
			   Object[#Object].Type = 'Chest'
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
	Collider:addToGroup("Link",Link)
end

function updateLink(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   local dx,dy = 0,0
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
   
   Link:move(dx,dy)
end

function addFoes()
   Foes = {}
   addFoe(100,100,'snake')
   addFoe(200,100,'snake')
   addFoe(300,100,'snake')
   addFoe(400,100,'snake')
   addFoe(200,500,'goron')
end

function addFoe(x,y,foetype)
   if foetype == 'goron' then
      Foes[#Foes + 1] = Collider:addRectangle(x,y,24,30)
      Foes[#Foes].dir = {0,1} --vector for direction the Foe is facing (x,y)
      Foes[#Foes].speed = 30
      Foes[#Foes].Type = 'Foe'
      Foes[#Foes].sprite = 'goron'
   elseif foetype == 'snake' then
      Foes[#Foes + 1] = Collider:addRectangle(x,y,20,24)
      Foes[#Foes].dir = {0,1} --vector for direction the Foe is facing (x,y)
      Foes[#Foes].speed = 40
      Foes[#Foes].Type = 'Foe'
      Foes[#Foes].sprite = 'snake'
   end
end

function removeFoes()
   for k,v in ipairs(Foes) do Collider:remove(v) end
end

function updateFoes(dt)
	local x,y
	for i=1,#Foes do
		Foes[i]:move(Foes[i].dir[1]*Foes[i].speed*dt,Foes[i].dir[2]*Foes[i].speed*dt)
	end
end

function addSword()
	Sword = Collider:addRectangle(0,0,24,24)
	Sword.Type = 'Sword'
	Collider:addToGroup('Link',Sword)
	Collider:setPassive(Sword)
end

function sword()
	if spressed then
		local x,y = Link:bbox()
		if     Link.heading == 'down' then Sword:moveTo(x+12,y+45)
		elseif Link.heading == 'up'   then Sword:moveTo(x+12,y-9)
		elseif Link.heading == 'right'then Sword:moveTo(x+36,y+15)
		elseif Link.heading == 'left' then Sword:moveTo(x-12,y+15)
		end
		Collider:setActive(Sword)
	else
		Collider:setPassive(Sword)
	end
end


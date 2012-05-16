function addObjects()
	Object = {}
	Portal = {}
	if Objects[currentworld] ~= nil then
		for i,v in ipairs(Objects[currentworld]) do
			if v[5] == 'Object' then
				Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
				Collider:addToGroup("Object",Object[#Object])
			else 
            Portal[v[5]] = Collider:addRectangle(v[1],v[2],v[3],v[4])
            Collider:addToGroup("Object",Portal[side])
			end
		end
	end
end

function removeObjects()
	for i=1,#Object do Collider:remove(Object[i]) end
	for k,v in pairs(Portal) do Collider:remove(v) end
end

function addLink(x,y,w,h)
	Link = Collider:addRectangle(x,y,w,h)
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
   addFoe(100,100,'goron')
   addFoe(200,100,'goron')
end

function addFoe(x,y,foetype)
	if foetype == 'goron' then
		Foes[#Foes + 1] = Collider:addRectangle(x,y,24,30)
		Foes[#Foes].dir = {0,1} --vector for direction the Foe is facing (x,y)
		Foes[#Foes].speed = 100
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
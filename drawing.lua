function drawworld(world1)
   --this is ugly make one big green background
   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	    love.graphics.draw(images[1],(n-1)*tilesize,(i-1)*tilesize)	 
      end
   end
   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	 if world1[i][n]~=-1 then
	    love.graphics.draw(images[world1[i][n]],(n-1)*tilesize,(i-1)*tilesize)
	 end
      end
   end   
end

function drawhouse(world)
   love.graphics.setColor(0,0,0)
   love.graphics.rectangle('fill',0,0,800,608)
   love.graphics.setColor(255,255,255)
   love.graphics.draw(images[world],280,224)
end


function drawmap(map)
   --Needs to change the map that unvisited areas are hidden for the player
   love.graphics.setColor(238,221,130)
   love.graphics.rectangle('fill',0,608,800,tilesize)
   for i=1,sizeoverworld[1] do
      for n=1, sizeoverworld[2] do
	 if i==coor[1] and n==coor[2] then love.graphics.setColor(255,0,0) 
	 elseif map[i][n]>0 then love.graphics.setColor(0,0,0)
	 else love.graphics.setColor(255,255,255) end
	 love.graphics.rectangle('fill',5+(n-1)*4,610+(i-1)*4,4,4)
      end
   end
   love.graphics.setColor(255,255,255)
end

function drawObjects(currentobjects)
   for i,v in ipairs(currentobjects) do
      if v[5]=='Gate' then  
	 love.graphics.draw(images[v[7]],v[1],v[2])
      elseif v[5]=='Arch' then  
	 love.graphics.draw(images[v[6]],v[1],v[2])
      else
	 tile=determinetilenumber(v[5])
	 if tile~=1 then
	    love.graphics.draw(images[tile],v[1],v[2])
	 end
      end
   end
	for i,v in ipairs(Rupee) do
		if v.exist then 
         if v.color == 'green' then rupee_green:draw(v.x,v.y)
         elseif v.color == 'blue' then rupee_blue:draw(v.x,v.y)
         elseif v.color == 'red' then rupee_red:draw(v.x,v.y) end
      end
	end
end

function drawHUD(health,inventory)
   x=64
   y=610
   for i=1,health do
      if i==5 then x=64 y=625 end --this puts the hearth in nice rows
  
      love.graphics.draw(images[55],x,y)
      x=x+17	 
   end
   --sword
   if havebettersword then love.graphics.draw(images[71],153,610)
   else love.graphics.draw(images[60],153,610) end
   --boomerang
   if haveboomerang then love.graphics.draw(images[72],185,610) end
   x=600
   for k,v in pairs(inventory) do 
      number=determinetilenumber(v)
      love.graphics.draw(images[number],x,610) 
      x=x+32 
   end
end

function determinetilenumber(name)
   number=1
   if name=='Key56' then number=56 
   elseif name=='Key57'then number=57
   elseif name=='Key58'then number=58
   elseif name=='Key59'then number=59
   elseif name=='Heart'then number=55
   elseif name=='Chest'then number=48
   elseif name=='OpenChest'then number=49
   elseif name=='bettersword'then number=71
   elseif name=='boomerangitem'then number=72
   end
return number
end
function loadtiles()
   mud=love.graphics.newImage("sprites/mud.gif")
   leaves=love.graphics.newImage("sprites/leaves.gif")
   water=love.graphics.newImage("sprites/water.gif")
   wall=love.graphics.newImage("sprites/wall.gif")

end


--creates an array of worlds
function createworlds() 
   worlds = {}
   for m=1,15 do
      worlds[m]=createworld()
   end
   gatedworlds= buildgates(worlds)
return gatedworlds
end


--creates a world and adds environment
function createworld()
   world = {}
   for i=1,verticaltiles do
      world[i]={}
      for n=1,horizontaltiles do
	 world[i][n]=1
	 if i==1 or i ==verticaltiles or n==1 or n==horizontaltiles then
	    world[i][n]=4 --wall around world
	 end
      end
   end
   --add forrest
   for i=0,math.random(0,10) do
      world[math.random(2,verticaltiles-2)][math.random(2,horizontaltiles-2)]=2
   end

   --add water
   
return world
end

function createoverworld()
   overworld = {}
   for i=0,sizeoverworld[1]+1 do
      overworld[i]={}
      for n=0, sizeoverworld[2]+1 do
	 overworld[i][n]=0
      end
   end
   --starting point
   overworld[3][6]=1
   --automated generation
   count = 2
   while true do
      for i=1,sizeoverworld[1] do
	 if count==15 then break end
	 for n=1, sizeoverworld[2]do
	    if count==15 then break end
	    --This needs work create nicer more branching worlds
	    if (overworld[i-1][n]~=0 or overworld[i+1][n]~=0 or overworld[i][n+1]~=0 or overworld[i][n-1]~=0) and overworld[i][n]==0 then
	       if math.random()>0.1 then 
		     overworld[i][n]=count
		     count=count+1
	       end
	    end
	 end
      end
      if count==15 then break end
   end
return overworld
end




function drawworld(world1)
   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	 if world1[i][n]== 1 then
	    love.graphics.draw(mud,(n-1)*tilesize,(i-1)*tilesize)
	 end
	 if world1[i][n]== 2 then
	    love.graphics.draw(leaves,(n-1)*tilesize,(i-1)*tilesize)
	 end
	 if world1[i][n]== 3 then
	    love.graphics.draw(water,(n-1)*tilesize,(i-1)*tilesize)
	 end
	 if world1[i][n]== 4 then
	    love.graphics.draw(wall,(n-1)*tilesize,(i-1)*tilesize)
	 end
      end
   end   
end

function drawmap(overworld)
   --Needs to change the map that unvisited areas are hidden for the player
   love.graphics.setColor(238,221,130)
   love.graphics.rectangle('fill',0,608,800,tilesize)
   for i=1,sizeoverworld[1] do
      for n=1, sizeoverworld[2] do
	 if overworld[i][n]==0 then
	    love.graphics.setColor(255,255,255)	 
	 elseif overworld[i][n]==currentworld then 
	    love.graphics.setColor(255,0,0)
	 else
	    love.graphics.setColor(0,0,0)
	 end
	 love.graphics.rectangle('fill',5+(n-1)*4,610+(i-1)*4,4,4)
      end
   end
end
--creates gates between worlds, can only be generated after all worlds are generated
function buildgates(worlds)
   gatedworlds=worlds
   for i=1,sizeoverworld[1] do
      for n=1,sizeoverworld[2]do
	 if overworld[i][n]~=0 then
	    --add north gate
	    if overworld[i-1][n]~=0 then
	        worlds[overworld[i][n]][1][12]=1
		worlds[overworld[i][n]][1][13]=1
		worlds[overworld[i][n]][1][14]=1
	    end
	    --add south gate
	    if overworld[i+1][n]~=0 then
	        worlds[overworld[i][n]][19][12]=1
		worlds[overworld[i][n]][19][13]=1
		worlds[overworld[i][n]][19][14]=1
	    end
	    --add west gate
	    if overworld[i][n+1]~=0 then
	        worlds[overworld[i][n]][10][25]=1
		worlds[overworld[i][n]][11][25]=1
	    end	    
	    --add east gate
	    if overworld[i][n-1]~=0 then
	        worlds[overworld[i][n]][10][1]=1
		worlds[overworld[i][n]][11][1]=1
	    end	
	 end
      end
   end

return gatedworlds
end
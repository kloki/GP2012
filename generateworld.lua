function loadtiles()
   mud=love.graphics.newImage("sprites/mud.gif")
   leaves=love.graphics.newImage("sprites/leaves.gif")
   water=love.graphics.newImage("sprites/water.gif")

end


function createworld()
   world = {}
   for i=1,verticaltiles do
      world[i]={}
      for n=1,horizontaltiles do
	 world[i][n]=math.random(1,3)
      end
   end  
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

function drawworld(world)
   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	 if world[i][n]== 1 then
	    love.graphics.draw(mud,(n-1)*tilesize,(i-1)*tilesize)
	 end
	 if world[i][n]== 2 then
	    love.graphics.draw(leaves,(n-1)*tilesize,(i-1)*tilesize)
	 end
	 if world[i][n]== 3 then
	    love.graphics.draw(water,(n-1)*tilesize,(i-1)*tilesize)
	 end

      end
   end   
end

function drawmap(overworld)
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
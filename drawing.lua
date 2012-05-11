function drawworld(world1)
   --this is ugly make one big green background
   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	    love.graphics.draw(images[1],(n-1)*tilesize,(i-1)*tilesize)	 
      end
   end

   for i=1,verticaltiles do
      for n=1,horizontaltiles do
	 if world1[i][n]>-1 then
	    love.graphics.draw(images[world1[i][n]],(n-1)*tilesize,(i-1)*tilesize)
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
   love.graphics.setColor(255,255,255)
end

function drawHUD(health)
   x=64
   for i=1,health do
     love.graphics.draw(heart,x,610)
     x=x+17
   end
end
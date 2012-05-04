function loadtiles()
   mud=love.graphics.newImage("sprites/mud.gif")
   leaves=love.graphics.newImage("sprites/leaves.gif")
   water=love.graphics.newImage("sprites/water.gif")

end


function createworld()
   world = {}
   for i=1,19 do
      world[i]={}
      for n=1,25 do
	 world[i][n]=math.random(1,3)
      end
   end
return world
end

function drawworld(world)
   for i=1,19 do
      for n=1,25 do
	 if world[i][n]== 1 then
	    love.graphics.draw(mud,(n-1)*32,(i-1)*32)
	 end
	 if world[i][n]== 2 then
	    love.graphics.draw(leaves,(n-1)*32,(i-1)*32)
	 end
	 if world[i][n]== 3 then
	    love.graphics.draw(water,(n-1)*32,(i-1)*32)
	 end

      end
   end   
end
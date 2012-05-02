require('movementHandler')

function love.load()
   love.graphics.setBackgroundColor(255,255,255)

   tilewidth=250
   tileheight=200
   plane=love.graphics.newImage("sprites/planesmall.gif")
   mud=love.graphics.newImage("sprites/mud.gif")
   leaves=love.graphics.newImage("sprites/leaves.gif")
   water=love.graphics.newImage("sprites/water.gif")
   world=createworld()

   speed = 200
   xplane=300
   yplane=300
   width=plane:getWidth()
   height =plane:getHeight()
   headingplane=0
end

function love.draw()

   drawworld(world)
   love.graphics.draw(plane,xplane,yplane,headingplane,1,1,width/2,height/2)
end

function love.update(dt)
   movementHandler(dt)
end

function createworld()
   world = {}
   for i=1,20 do
      world[i]={}
      for n=1,25 do
	 world[i][n]=math.random(1,3)
      end
   end
return world
end

function drawworld(world)
   for i=1,20 do
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
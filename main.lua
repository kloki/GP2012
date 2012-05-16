require('generateworld')
require('movementHandler')
require('SpriteAnima')
require('goron')
require('drawing')
HC = require 'HardonCollider'
require 'TEsound'
require 'collision'
require('util')

function love.load()
   --some debug stuff
   test_output = 'none'

   --initialize library
   Collider = HC(100, on_collision, collision_stop)
   
   --load music
   TEsound.playLooping("music/windfall-island.mp3")
   
   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   numberofworlds=40 --no more than 6*12
   loadtiles()
   Objects={}
   for i=1,numberofworlds do
      Objects[i]={}
   end
   currentworld=1
   coor={3,6} --y,x
   overworld=createoverworld()
   worlds=createworlds()
   w_height= love.graphics.getHeight()
   w_width = love.graphics.getWidth
   Object = {}
   Portal = {0,0,0,0}
   addObjectBB()
   
   --zelda
   heart=love.graphics.newImage("sprites/heart.png")
   health=4

   --setup enemies
   number_of_gorons = 5
   goron_bb = {}
   goron_speed = 50
   spawnGorons()
   
   --add tree bounding boxes,not fully working yet
   --addTreeBB()

   -- setup link
   speed = 200
   d_speed = 140
   xsprite=300
   ysprite=300
   loadSprite()
   spressed = false
   heading = 'down'
   addLinkBB()
   
   --change this to good variables
   width_sprite = 60
   height_sprite = 60
   headingplane=0
   move = 'none'
   stop = 'down'
end

function love.draw()
   drawworld(worlds[currentworld])
   drawmap(overworld)
   drawHUD(health)
   drawSprite()
   for k,v in pairs(gorons) do
      v:draw()
      local x,y,_,_ = v:getPosition()
      love.graphics.print(tostring(v:getID()),x,y)
   end

   --for debug draw bounding boxes
   local i,v
   for i,v in ipairs(Object) do Object[i]:draw('line') end
   for i,v in ipairs(goron_bb) do goron_bb[i]:draw('line') end
   love.graphics.setColor(255,0,0,255)
   for i=1,#Portal do 
      if type(Portal[i]) ~= 'number' then Portal[i]:draw('line')  end
   end
   love.graphics.setColor(255,255,255,255)
   LinkBB:draw('line')
   
   love.graphics.print(test_output,100,100)
end

function love.update(dt)
   updateSprite(dt)
   --update enemy position
   for k,v in pairs(gorons) do
      v:update(dt)
      local x,y,_,_ = v:getPosition()
      goron_bb[v:getID()]:moveTo(x,y)
   end
   local oldworld = currentworld
   
   --update links position
   movementHandler(dt,coor)
   --handle collisions
   Collider:update(dt)
   --spawn new enemies when changing worlds
   if currentworld ~= oldworld then
      spawnGorons()
      removeObjectBB()
      addObjectBB()
   end
   
   TEsound.cleanup()
end

function love.keypressed(k)
   if k == ' ' then
      spressed = true
   end
   if k == 'q' then
      love.event.push("quit")
      love.event.push("q")
   end
   if k == 'r' then
      --respawn enemies--
      spawnGorons()
   end
end

function love.keyreleased(k)
   move = 'none'
   stop = k
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end

function addLinkBB()
   LinkBB = Collider:addRectangle(xsprite,ysprite,24,30)
   Collider:addToGroup('Link',LinkBB)
end

--add the bounding boxes for walls and other objects
function addObjectBB()
   Object[1] = Collider:addRectangle(0,-100+tilesize,  800,100) 	--Up egdge (Top)
   Object[2] = Collider:addRectangle(0,640-2*tilesize, 800,100)		--Down edge
   Object[3] = Collider:addRectangle(-100+tilesize,tilesize,  100,640-3*tilesize)	--Left edge	
   Object[4] = Collider:addRectangle(800-tilesize, tilesize,  100,640-3*tilesize)	--Right edge
   for i=1,4 do Collider:addToGroup("Objects",Object[i]) end
   if Objects[currentworld] ~= nil then
      for i,v in ipairs(Objects[currentworld]) do
         if v[5] == 'Object' then
            Object[#Object+1] = Collider:addRectangle(v[1],v[2],v[3],v[4])
            Collider:addToGroup("Object",Object[#Object])
         else 
            local side = 0
            if v[5] == 'North' then side = 1
            elseif v[5] == 'East' then side = 2
            elseif v[5] == 'South' then side = 3
            elseif v[5] == 'West' then side = 4 end
            Portal[side] = Collider:addRectangle(v[1],v[2],v[3],v[4])
            Collider:addToGroup("Object",Portal[side])
         end
      end
   end
end

function removeObjectBB()
   for i=1,#Object do
      Collider:remove(Object[i])
      Object[i] = nil
   end
   for i=1,#Portal do
      if type(Portal[i]) ~= 'number' then 
         Collider:remove(Portal[i])
         Portal[i] = 0
      end
   end
end
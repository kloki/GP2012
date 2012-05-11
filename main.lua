require('generateworld')
require('movementHandler')
require('SpriteAnima')
require('goron')
require('drawing')
HC = require 'HardonCollider'
require 'collision'
require('util')

function love.load()
   --initialize library
   Collider = HC(100, on_collision, collision_stop)

   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   numberofworlds=40 --no more than 6*12
   loadtiles()
   overworld=createoverworld()
   worlds=createworlds()
   currentworld=1
   coor={3,6}
   w_height= love.graphics.getHeight()
   w_width = love.graphics.getWidth()
   border = {}
   --TODO these rectangles always collide, solve!
   border[1] = Collider:addRectangle(0,-100+tilesize,  800,100) 	--Up egdge (Top)
   border[2] = Collider:addRectangle(0,640-2*tilesize, 800,100)		--Down edge
   border[3] = Collider:addRectangle(-100+tilesize,tilesize,  100,640-3*tilesize)	--Left edge	
   border[4] = Collider:addRectangle(800-tilesize, tilesize,  100,640-3*tilesize)	--Right edge
   for i=1,4 do Collider:addToGroup("Objects",border[i]) end   
   
   --zelda
   heart=love.graphics.newImage("sprites/heart.png")
   health=4

   --setup sprites
   goron_bb = {}
   spawnGorons()

   -- setup link
   loadSprite()
   spressed = false
   heading = 'down'

   --temporary stuff
   speed = 200
   goron_speed = 150
   d_speed = 140
   xsprite=300
   ysprite=300
   --change this to good variables
   width_sprite = 60
   height_sprite = 60
   headingplane=0
   move = 'none'
   stop = 'down'
   output = 'none'
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
   --spawn new enemies when changing worlds
   if currentworld ~= oldworld then
      spawnGorons()
   end
   Collider:update(dt)
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

function spawnGorons()
   gorons = {}
   for i,v in ipairs(goron_bb) do
      Collider:remove(v)
   end
   for i=1,5 do
      table.insert(gorons, Goron.create(i))
   end
end

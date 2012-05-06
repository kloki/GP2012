require('generateworld')
require('movementHandler')
require('SpriteAnima')
require('goron')

function love.load()

 
   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   numberofworlds=25 --no more than 6*12
   loadtiles()
   overworld=createoverworld()
   worlds=createworlds()
   currentworld=1
   coor={3,6}
   w_height= love.graphics.getHeight()
   w_width = love.graphics.getWidth()

   --setup sprites
   loadSprite()
   gorons = {}
   --spawnGoron(30)
   --spawnGoron(30)
   table.insert(gorons, Goron.create())
   table.insert(gorons, Goron.create())
   table.insert(gorons, Goron.create())
   table.insert(gorons, Goron.create())
   for k,v in pairs(gorons) do
      v:loadSprites()
   end
   --goron2 = Goron.create()
   --goron:loadSprites()
   --goron2:loadSprites()

   --temporary stuff
   speed = 200
   goron_speed = 30
   d_speed = 140
   xsprite=300
   ysprite=300
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
   drawSprite()
   --for k,v in pairs(gorons) do
   --   love.graphics.drawq(goron_sheet,goronfrontS, v:getX(), v:getY())
	--end
   for k,v in pairs(gorons) do
      v:draw()
   end
   --goron2:draw()
   --drawEnemy()
   --love.graphics.draw(sprite,xsprite,ysprite,headingplane,1,1,width_sprite/2,height_sprite/2)

end

function love.update(dt)
   updateSprite(dt)
   for k,v in pairs(gorons) do
      v:update(dt)
   end
   --goron2:update(dt)
   movementHandler(dt,coor)
end

function love.keypressed(k)
   move = k
   if k == 'q' then
      love.event.push("quit")
   end
end

function love.keyreleased(k)
   move = 'none'
   stop = k
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end



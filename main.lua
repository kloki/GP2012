require('generateworld')
require('movementHandler')
require('SpriteAnima')
require('enemy')

function love.load()

 
   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   loadtiles()
   worlds=createworlds()
   overworld=createoverworld()
   currentworld=1

   --setup sprites
   loadSprite()
   spawnEnemie()


   --temporary stuff
   sprite=love.graphics.newImage("sprites/planesmall.gif")  
   speed = 200
   d_speed = 140
   xsprite=300
   ysprite=300
   width_sprite  =sprite:getWidth()
   height_sprite =sprite:getHeight()
   headingplane=0
   move = 'none'
end

function love.draw()
   drawworld(worlds[currentworld])
   drawmap(overworld)
   drawSprite()
   --love.graphics.draw(sprite,xsprite,ysprite,headingplane,1,1,width_sprite/2,height_sprite/2)

end

function love.update(dt)
   updateSprite(dt)
   movementHandler(dt)
end

function love.keypressed(k)
   move = k
   if k == 'q' then
      love.event.push("quit")
   end
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end



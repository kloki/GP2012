require('generateworld')
require('movementHandler')
require('SpriteAnima')

function love.load()

 
   --setup world
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   loadtiles()
   world=createworld()
   overworld=createoverworld()
   currentworld=0

   --setup sprites
   loadSprite()



   --temporary stuff
   plane=love.graphics.newImage("sprites/planesmall.gif")  
   speed = 200
   d_speed = 140
   xsprite=300
   ysprite=300
   width=plane:getWidth()
   height =plane:getHeight()
   headingplane=0
end

function love.draw()


   drawmap(overworld)
   drawworld(world)
   love.graphics.draw(plane,xsprite,ysprite,headingplane,1,1,width/2,height/2)
end

function love.update(dt)

   movementHandler(dt)
end

function love.keypressed(k)
   if k == 'q' then
      love.event.push("quit")
   end
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end



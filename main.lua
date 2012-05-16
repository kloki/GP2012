require 'generateworld'
HC = require 'HardonCollider'
require 'TEsound'
require 'Collide'
require 'util'
require 'drawing'
require 'objectHandling'
require 'SpriteAnima'

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
   w_width = love.graphics.getWidth()
	addObjects()
   
   --zelda
   heart=love.graphics.newImage("sprites/heart.png")
   health=4

   --setup enemies
   number_of_enemies = 5
   enemy_speed = 50

   -- setup link
   speed   = 200
   d_speed = 140
	addLink(300,300,24,30)
	loadSprites()
	
	--setup enemies
	Foes = {}
	addFoe(100,100,'goron')
end

--The screen is drawn in three steps
--:World map
--:Link
--:Enemies
function love.draw()
	--WORLD
   drawworld(worlds[currentworld])
   drawmap(overworld)
   drawHUD(health)
	
	--LINK
	drawSprite()
	
	--ENEMIES
	drawFoes()
	
   --DEBUG
	--for debug draw bounding boxes
	for i=1,#Object do Object[i]:draw('line') end
	Link:draw('line')
	for i=1,#Foes do Foes[i]:draw('line') end
   love.graphics.print(test_output,100,100)
end

function love.update(dt)
	--update sprite animation and position
	updateLink(dt)
	updateSprite(dt)
	updateFoes(dt)
   --handle collisions
   Collider:update(dt)
	--handle music streams
   TEsound.cleanup()
end

function love.keypressed(k)
   if k == 'q' then
      love.event.push("quit")
      love.event.push("q")
   end
end

function love.keyreleased(k)
   move = 'none'
   stop = k
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end
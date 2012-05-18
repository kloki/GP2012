require 'generateworld'
HC = require 'HardonCollider'
require 'TEsound'
require 'Collide'
require 'util'
require 'drawing'
require 'objectHandling'
require 'SpriteAnima'
require 'StartUp'

function love.load()
   --some debug stuff
   test_output = 'none'

   -- startupscreens and menu stuff
   startup = true
   loadStart()
   bttn = 'none'

   --initialize library
   Collider = HC(100, on_collision, collision_stop)
   
   --load music
   --TEsound.playLooping("music/windfall-island.mp3")
   
   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   numberofworlds=4 --no more than 6*12
   loadtiles()
   Objects={}
   for i=1,numberofworlds do
      Objects[i]={}
   end
   currentworld=1
   coor={3,6} --y,x
   overworld=createoverworld()
   worlds=createworlds()
   addObjects()
   
   --zelda
   
   health=7
   inventory={}

   --setup enemies
   number_of_enemies = 5
   enemy_speed = 50

   -- setup link
   speed   = 200
   d_speed = 140
	addLink(300,300,24,30)
	loadSprites()
	addSword()
	
	--setup enemies
	Foes = {}
	addFoes()
end

--The screen is drawn in three steps
--:World map
--:Link
--:Enemies
function love.draw()
   if startup or health==0 then
      drawStart()
   else
	   --WORLD
      drawworld(worlds[currentworld])
      drawmap(overworld)
      drawHUD(health,inventory)
	   
	   --LINK
	   drawSprite()
	   
	   --ENEMIES
	   drawFoes()
	   
      --DEBUG
	   --for debug draw bounding boxes
	   for i=1,#Object do Object[i]:draw('line') end
	   Link:draw('line')
	   for i=1,#Foes do Foes[i]:draw('line') end
	   love.graphics.setColor(255,0,0)
	   for k,v in pairs(Portal) do v:draw('line') end
	   Sword:draw('line')
	   love.graphics.setColor(255,255,255)
      love.graphics.print(test_output,100,100)
   end
end

function love.update(dt)
   if startup then
      updateStart(dt)
   else
   	local oldworld = currentworld
	   --update sprite animation and position
	   updateLink(dt)
	   updateSprite(dt)
	   updateFoes(dt)
      --handle collisions
      Collider:update(dt)
	   if oldworld ~= currentworld then
	   	removeObjects() 
         removeFoes()
	   	addObjects()
         addFoes()
	   end
	   --handle music streams
      TEsound.cleanup()
   end
end

function love.keypressed(k)
   bttn = k
	if k == ' ' then 
		spressed = true 
	end
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

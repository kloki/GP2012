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
   TEsound.playLooping("music/menu-selection.mp3","music")
   TEsound.tagVolume("music", 0.5)
   
   --setup world
   tilesize=32
   horizontaltiles=25
   verticaltiles=19
   sizeoverworld={6,12}
   numberofworlds=25 --no more than 6*12
   loadtiles()
   Objects={}
   Spawnpoints={}--Spawnpoint[x]={{x,y},{x,y},...}
   for i=1,numberofworlds do
      Objects[i]={}
   end
   currentworld=1
   coor={3,6} --y,x
   overworld=createoverworld()
   worlds=createworlds()
   addObjects()

   -- setup link
	health=4
	Rupees = 0
   inventory={}
   speed   = 200
   d_speed = 140
	cool_time = 0.7
	addLink(300,300,24,30)
	loadSprites()
	addSword()
   --addBoem()
	
	--setup enemies
	Foes = {}
	addFoes()
	
	Rupee = {}
end

--The screen is drawn in three steps
--:World map
--:Link
--:Enemies
function love.draw()
   if startup or health==0 or bttn == 'escape' then
      drawStart()
   else
      --WORLD
      if currentworld>numberofworlds then 
		drawhouse(worlds[currentworld])

      else  
		drawworld(worlds[currentworld]) 

      end
      drawmap(overworld)
      drawHUD(health,inventory)
      drawObjects(Objects[currentworld])
      --LINK
      drawSprite()
      
      --ENEMIES
      drawFoes()
      
      --RUPEES
      rupee_green:draw(tilesize*7,tilesize*19.2)
      love.graphics.setColor(0,0,0)
		love.graphics.print(tostring(Rupees),tilesize*8,tilesize*19.2)
      love.graphics.setColor(255,255,255)
      
      --DEBUG
      for i=1,#Object do Object[i]:draw('line') end
      Link:draw('line')
      for i=1,#Foes do Foes[i]:draw('line') end
      love.graphics.setColor(255,0,0)
      for k,v in pairs(Portal) do v:draw('line') end
      		--for k,v in pairs(Rupee) do v:draw('line') end
      Sword:draw('line')
      --Boem:draw('line')

      love.graphics.setColor(255,255,255)
      fps = love.timer.getFPS( )
      test_output = test_output .. tostring(fps)
      love.graphics.print(test_output,100,100)
      
   end
end

function love.update(dt)
   test_output = ''
   if startup or bttn == 'escape' then
      updateStart(dt)
      start = true
   else
      local oldworld = currentworld
      --update sprite animation and position
      updateLink(dt)
      updateSprite(dt)
      updateFoes(dt)
      sword()
      --boem()
      --handle collisions
      Collider:update(dt)
      --change of worlds
      if oldworld ~= currentworld then
         removeObjects() 
         removeFoes()
         addObjects()
         addFoes()
      end
      --music
      if start then 
         TEsound.stop("music")
         start = false
         TEsound.playLooping({"music/windfall-island.mp3","music/dragon-roost-island.mp3","music/outset-island.mp3","music/hyrule-fields.mp3" },"music")
      end
      TEsound.cleanup()
   end
end

function love.keypressed(k)
   bttn = k
   print(bttn)

   -- space bttn for sword
	if k == ' ' then 
		spressed = true
      TEsound.play({"sound-effects/Sword1.wav","sound-effects/Sword2.wav","sound-effects/Sword3.wav"},"effect")
	end

   -- control button for Boemerang
   if k == 'lctrl' or k == 'rctrl' then
      cpressed = true
   end


   if k == 'q' then
      love.event.push("quit")
      love.event.push("q")
   end
   if k== 'b' then
      bpressed = true
      --play boomerang sound
   end
   if k == 'escape' then
      epressed = true
      startup = true
   end
end

function love.keyreleased(k)
   move = 'none'
   stop = k
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end

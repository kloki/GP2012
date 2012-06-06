require 'generateworld'
HC = require 'HardonCollider'
require 'TEsound'
require 'Collide'
require 'util'
require 'drawing'
require 'objectHandling'
require 'SpriteAnima'
require 'StartUp'
require 'Text'

function love.load()
   --some debug stuff
   test_output = 'none'

   -- startupscreens and menu stuff
   startup = true
   loadStart()
   bttn = 'none'

   -- alle text
   loadText()
   

   --initialize library
   Collider = HC(100, on_collision, collision_stop)
   
   --load music
   musvol = 0.5
   sounvol = 0.5
   TEsound.stop("music")
   TEsound.playLooping("music/menu-selection.mp3","music")
   TEsound.tagVolume("music", musvol)
   TEsound.tagVolume("boomerang",sounvol)
   
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
   knownmap={}
   for i=1,6 do
      knownmap[i]={0,0,0,0,0,0,0,0,0,0,0,0}
   end
   knownmap[3][6]=1
   worlds=createworlds()
   addObjects()

   -- setup link
   win = false
   health=4
   Rupees = 0
   havebettersword=false
   haveboomerang=false
   damage=1
   inventory={}
   speed   = 200
   d_speed = 140
   cool_time = 0.7
   addLink(300,300,24,30)
   loadSprites()
   addSword()
   addBoomerang()
   
   --setup enemies
   Foes = {}
   addFoes()
   
   --setup Zelda
   addZelda()
   
   Rupee = {}
   
   godmode = true
   Debug = true
end

--The screen is drawn in three steps
--:World map
--:Link
--:Enemies
function love.draw()
   if startup or health==0 or bttn == 'escape' or win then
      drawStart()
   else
      --WORLD
      if currentworld>numberofworlds then 
		drawhouse(worlds[currentworld])

      else  
		drawworld(worlds[currentworld]) 

      end
      drawmap(overworld)
      --drawmap(knownmap)
      drawHUD(health,inventory)
      drawObjects(Objects[currentworld])
      drawWeapons()
      --LINK
      drawSprite()
      --Zelda
      drawZelda()
      
      --ENEMIES
      drawFoes()
      
      --TEXT
      drawText()

      --RUPEES
      rupee_green:draw(tilesize*7,tilesize*19.2)
      love.graphics.setColor(0,0,0)
      love.graphics.print(tostring(Rupees),tilesize*8,tilesize*19.2)
      love.graphics.setColor(255,255,255)
      
      --DEBUG
      if Debug then
         for i=1,#Object do Object[i]:draw('line') end
         Link:draw('line')
         for i=1,#Foes do Foes[i]:draw('line') end
         love.graphics.setColor(255,0,0)
         for k,v in pairs(Portal) do v:draw('line') end
               --for k,v in pairs(Rupee) do v:draw('line') end
         Sword:draw('line')
         Boomerang:draw('line')

         love.graphics.setColor(255,255,255)
         fps = love.timer.getFPS( )
         test_output = test_output .. tostring(fps)
         love.graphics.print(test_output,100,100)
      end
      
   end
end

function love.update(dt)
   test_output = ''
   if startup or bttn == 'escape' or health == 0 or win then
      updateStart(dt)
   else
      local oldworld = currentworld
      --update sprite animation and position
      updateLink(dt)
      updateSprite(dt)
      updateFoes(dt)
      updateWeapons(dt)
      updateZelda(dt)
      sword()
      updateText(dt)
      --boem()
      --handle collisions
      Collider:update(dt)
      --change of worlds
      if oldworld ~= currentworld then
         removeObjects() 
         removeFoes()
         removeBoomerang()
         addObjects()
         addFoes()
         if currentworld == 2*numberofworlds then
            TEsound.play("sound-effects/Zelda_Hey.wav","effect")
            Zelda.active = true
         else
            Zelda.active = false
         end
      end
      --music
      if start then 
         TEsound.stop("music")
         start = false
         TEsound.playLooping({"music/windfall-island.mp3","music/dragon-roost-island.mp3","music/outset-island.mp3","music/hyrule-fields.mp3" },"music")
	 TEsound.volume("music", musvol)
	 
      end
      TEsound.cleanup()
   end
end

function love.keypressed(k)
   bttn = k
   if k== 'i' then
      TEsound.volume("music", 0)
   end
   -- space bttn for sword
	if k == ' ' then
      spressed = true
      if startup == false then
         TEsound.play({"sound-effects/Sword1.wav","sound-effects/Sword2.wav","sound-effects/Sword3.wav"},"effect")
      end   
	end

   if k == 'q' then
      love.event.push("quit")
      love.event.push("q")
   end
   if haveboomerang and k== 'b' then
      if Boomerang.active == false then
         bpressed = true
         initBoomerang()
      end
      --play boomerang sound
   end
   if k == 'escape' then
      epressed = true
      startup = true
   end
   if k == 'd' then Debug = not(Debug) end
   if k == 'g' then godmode = not(godmode) end
end

function love.keyreleased(k)
   move = 'none'
   stop = k
end

function love.quit()
  print("Thanks for playing. Please play again soon!")
end

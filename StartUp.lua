function loadStart()
   --first startupscreen
   Slove = love.graphics.newImage("tiles/start/Love.png")
   Smenu = love.graphics.newImage("tiles/start/mainmenu.png")
   h=love.graphics.getHeight()
   print(h)   

   --mooie font en achtergrondkleur
   local f = love.graphics.newFont("tiles/start/adam.ttf",20)
   love.graphics.setFont(f)
   
   
   --wat variablen
   timer = 0
   case = 'love'
   love.graphics.setBackgroundColor(18,18,18)

end

function drawStart()
   if case == 'love' then
      --love.graphics.setColor(0,100,0,255)
      love.graphics.draw(Slove,0,100)
   elseif case == 'main' then
      love.graphics.draw(Smenu,0,0)
      --love.graphics.setColor(0,100,0,255)
      love.graphics.print("MainMenu", 100, 100)
   elseif case == 'gameover' then

      --love.graphics.setColor(0,100,0,255)
      --love.graphics.print("GAME OVER", 100, 100)
   end
end

function updateStart(dt)
   timer = timer + 1
   if health == 0 then
      case = 'main'
   end

   if case == 'love' then
      if spressed or timer == 200 then
         spressed = false
         case ='main'
         timer = 0
      end
   elseif case == 'main' then
      if spressed then
         startup = false
         spressed = false
      end
   elseif case == 'gameover' then
      startup = true
      if spressed then
         case = 'main'
         health = 4
      end
   end
end




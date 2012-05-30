function loadStart()
   --first startupscreen
   Slove = love.graphics.newImage("tiles/start/Love.png")
   Smenu = love.graphics.newImage("tiles/start/mainmenu.png")
   Ssprite = love.graphics.newImage("tiles/start/MC-Items.png")
   Ssword = love.graphics.newQuad(0,0,25,27,180,274)
   Ssword:flip(true,false)
   gameover = love.graphics.newImage("tiles/start/gameover.png")
   dieS = love.graphics.newImage("sprites/die.png")
   die =  newAnimation(dieS,25,40,0.15,13,1,1)
   die:setMode("once")
   m = 's'
   bp= false


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
      love.graphics.setColor(255,255,255,255)
      love.graphics.draw(Smenu,0,0)
      if m == 's' then
         love.graphics.drawq(Ssprite,Ssword,330,157)
      elseif m == 'o' then
         love.graphics.drawq(Ssprite,Ssword,330,212)
      elseif m == 'e' then
         love.graphics.drawq(Ssprite,Ssword,330,267)
      end
   elseif case == 'gameover' then
      love.graphics.setColor(255,255,255,255)
      love.graphics.draw(gameover)
      die:draw(400,320)
   elseif case == 'options' then
      love.graphics.setColor(0,100,0,255)
      love.graphics.print('Options', 200,200 )
   end
end

function updateStart(dt)
   timer = timer + 1
   if health == 0 then
      case = 'gameover'
   end
   
   if bttn == 'escape' then
      case = 'main'
   end

   if case == 'love' then
      if spressed or timer == 200 then
         spressed = false
         case ='main'
         timer = 0
      end
   elseif case == 'main' then
      if bttn == 'down' or bttn == 'up' then
         m=button(m)
         bttn=none
      end
      if m == 's' and spressed then
         startup = false
         spressed = false
      elseif m == 'o' and spressed then
         case = 'options'
      elseif m == 'e' and spressed then
         love.event.push("quit")
      end
   elseif case == 'options' then
   elseif case == 'gameover' then
      die:update(dt)
      startup = true
      if spressed then
         die:reset()
         spressed = false
         case = 'main'
         health = 4
      end
   end
end


function button(mp)
   print(bttn)
   if mp == 's' then
      if bttn == 'down' then
         --print('down',mp )
         mp = 'o'
      elseif bttn == 'up' then
         --print('up')
         mp = 'e'
      end
   elseif mp == 'o' then
      if bttn == 'down' then
         --print('down',mp)
         mp = 'e'
      elseif bttn == 'up' then
         --print('up')
         mp = 's'
      end
   elseif mp == 'e' then
      if bttn == 'down' then
         --print('down')
         mp = 's'
      elseif bttn == 'up' then
         --print('up')
         mp = 'o'
      end
   else
      mp = mp
   end
   return mp
end


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
   m = 0
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
      if m == 0 then
         love.graphics.drawq(Ssprite,Ssword,330,157)
      elseif m == 1 then
         love.graphics.drawq(Ssprite,Ssword,330,212)
      elseif m == 2 then
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
   --print(case)
   timer = timer + 1
   if health == 0 then
      case = 'gameover'
      startup = true
   end
   
   if epressed then
      case = 'main'
   end

   if case == 'love' then
      if spressed or timer == 200 then
         spressed = false
         case ='main'
         timer = 0
      end
   elseif case == 'main' then
      epressed = false
      if bttn == 'down' or bttn == 'up' then
         m=button(m,3)
         bttn=none
      end
      if m == 0 and spressed then
         startup = false
         spressed = false
      elseif m ==1 and spressed then
         case = 'options'
      elseif m == 2 and spressed then
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


function button(mp,v)
   print(bttn)
   if bttn == 'down' then
      mp = (mp +1)%v
   elseif bttn == 'up' then
      mp = (mp - 1)%v
   else
      mp = mp
   end
   return mp
end


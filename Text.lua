function loadText()
   count = 0
   begin = love.graphics.newImage("sprites/Startbaloon.png")
   gateru = love.graphics.newImage("sprites/gateru.png")
   gateld = love.graphics.newImage("sprites/gateld.png")
   swordfoun = love.graphics.newImage("sprites/foundsword.png")
   boemfoun = love.graphics.newImage("sprites/founboem.png")

   botsgate = false
   gamestarted = false
   fouboe = false
   swofo = false
end

function drawText()
   local x,y = Link:bbox()

   if gamestarted then
      love.graphics.draw(begin,x-180,y-110)
   end
   if botsgate then
      if x < 100 or y > 500 then
         love.graphics.draw(gateld,x+5,y-110)
      elseif y < 100 or x > 700 then
         love.graphics.draw(gateru,x-185,y+20)
      end
   end
   if swofo then
      love.graphics.draw(swordfoun,x-180,y-110)
   end
   if fouboe then
      love.graphics.draw(boemfoun,x-180,y-110)
   end 
end

function updateText(dt)
   if gamestarted then
      count = count + 1
      if count < 150 then
          gamestarted = true
      else
         gamestarted = false
         count = 0
      end
   end
   if botsgate or drawgate then
      botsgate = false
   end
   if foundboem then
      count = count + 1
      if count < 150 then
         foundboem = true
      else
         foundboem = false
         count = 0
      end
   end
   if swofo then
      count = count + 1
      if count < 150 then
         foundboem = true
      else
         foundboem = false
         count = 0
      end
   end
end



function loadText()
   count = 0
   begin = love.graphics.newImage("sprites/Startbaloon.png")
   gateru = love.graphics.newImage("sprites/gateru.png")
   gateld = love.graphics.newImage("sprites/gateld.png")

   botsgate = false
   gamestarted = false
   foundboem = false
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
   if botsgate then
      count = count + 1
      if count < 150 then
         botsgate = true
      else
         botsgate =false
         count = 0
      end
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
end



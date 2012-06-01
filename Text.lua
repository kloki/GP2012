function loadText()
   count = 0
   begin = love.graphics.newImage("sprites/Startbaloon.png")
end

function drawText()
   local x,y = Link:bbox()
   if count < 300 then
      love.graphics.draw(begin,x-180,y-110)
   end      
end

function updateText(dt)
   count = count + 1
end



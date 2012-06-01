function loadText()
   count = 0
   begin = love.graphics.newImage("sprites/Startbaloon.png")

   botsgate = false
   start = true
end

function drawText()
   local x,y = Link:bbox()
   if count < 250 then
      if start then
         love.graphics.draw(begin,x-180,y-110)
         start = false
      end
   end      
end

function updateText(dt)
   count = count + 1
   if botsgate == true then
   end

end



require('goron')

function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function collisionDetection(gorons)
   for i,v in pairs(gorons) do
      ax1,ay1,aw,ah = v:getPosition(dt)
      for j,w in pairs(gorons) do
         if j>i then
            bx1,by1,bw,bh = w:getPosition(dt)
            if CheckCollision(ax1,ay1,aw,ah,bx1,by1,bw,bh) then
               w:collision()
               v:collision()
            end
         end
      end
   end
end
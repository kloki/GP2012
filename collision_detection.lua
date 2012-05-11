

--function collisionDetection(gorons)
--   for i,v in pairs(gorons) do
--      ax1,ay1,aw,ah = v:getPosition(dt)
--      for j,w in pairs(gorons) do
--         if j>i then
--            bx1,by1,bw,bh = w:getPosition(dt)
--            if CheckCollision(ax1,ay1,aw,ah,bx1,by1,bw,bh) then
--               w:collision()
--               v:collision()
--            end
--         end
--      end
--   end
--end
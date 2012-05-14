require 'HardonCollider'
require 'goron'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	local Type_a, Type_b, ind_a, ind_b = getType(shape_a,shape_b)
   
   if (Type_a == 'Object' and Type_b == 'goron') or (Type_a == 'goron' and Type_b == 'Object') then
      if Type_a == 'Object' then mtv_x,mtv_y, ind_a, ind_b = -mtv_x, -mtv_y, ind_b, ind_a end
      local w = getDirection(mtv_x,mtv_y)
      gorons[ind_a]:move(mtv_x*2,mtv_y*2) --why times two?
      gorons[ind_a]:turn(w)
      if ind_b > 4 then test_output = 'tree' end
   elseif (Type_a == 'goron' and Type_b == 'goron') then
      local xa,ya,_,_ = gorons[ind_a]:getPosition()
      local xb,yb,_,_ = gorons[ind_b]:getPosition()
      if xa<xb then
         gorons[ind_a]:bounce('right')
         gorons[ind_b]:bounce('left')
      else
         gorons[ind_a]:bounce('left')
         gorons[ind_b]:bounce('right')
      end
   elseif (Type_a == 'Link' and (Type_b == 'Object' or 'goron'))
       or (Type_b == 'Link' and (Type_a == 'Object' or 'goron')) then
      if Type_a == 'Object' or 'goron' then mtv_x,mtv_y = -mtv_x, -mtv_y end
      if Type_a == 'Object' or Type_b == 'Object' then
         xsprite = xsprite + mtv_x
         ysprite = ysprite + mtv_y
         LinkBB:move(mtv_x,mtv_y)
         test_output = 'link+wall'
      else
         test_output = 'link+goron'
         xsprite = xsprite + mtv_x
         ysprite = ysprite + mtv_y
         LinkBB:move(mtv_x,mtv_y)
      end
   elseif (Type_a == 'Portal' and Type_b == 'Link') or (Type_b == 'Portal' and Type_a == 'Link') then
      if Type_a == 'Portal' then ind_a, ind_b = ind_b, ind_a end
      local ix, iy
      if ind_b == 1 then     ix,iy = 0,-1
      elseif ind_b == 2 then ix,iy = 1,0
      elseif ind_b == 3 then ix,iy = 0,1
      elseif ind_b == 4 then ix,iy = -1,0 end
      current_world = overworld[coor[2] + iy][coor[1] + ix]
      local dx,dy = xsprite-ysprite
      xsprite = 300
      ysprite = 300
      LinkBB:move(300-dx,300-dy)
      test_output = 'link+portal'
   end
	--if shape_a = border[1] or shape_a = border[2] or shape_a = border[3] or shape_a = border[4] then	
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)

end

-- this function determines the location of the Object
-- and thus the direction in which can't be moved
function whichObject(Object_shape)
   for i = 1,4 do
      if Object_shape == Object[i] then
         return i
      end
   end
   error('direction not found')
end

function whichGoron(goron_shape)
   local gor_ind
   for k,v in pairs(gorons) do
      if     goron_bb[v:getID()] == goron_shape then 
         gor_ind = v:getID()
         return gor_ind
      end     
   end
   error('could not match shape')
end

-- determine type and index number
function getType(shape_a,shape_b)
   local Type_a, Type_b
   local ind_a, ind_b
   local i,v
   if shape_a == LinkBB then Type_a = 'Link' end
   if shape_b == LinkBB then Type_b = 'Link' end
   for i=1,#Object do
      if shape_a == Object[i] then Type_a, ind_a = 'Object', i end
      if shape_b == Object[i] then Type_b, ind_b = 'Object', i end
   end
   for i=1,#gorons do
      if shape_a == goron_bb[i] then Type_a, ind_a = 'goron', i end
      if shape_b == goron_bb[i] then Type_b, ind_b = 'goron', i end
   end
   for i=1,#Portal do
      if shape_a == Portal[i] then Type_a, ind_a = 'Portal', i end
      if shape_b == Portal[i] then Type_b, ind_b = 'Portal', i end
   end
   --TODO solve this as it gives problems with collision detection
   --assert(type(ind_a) == "number", "ind_a of type: '" .. Type_a .. "' in function 'getType' must be number or nil")
   --assert(type(ind_b) == "number", "ind_b of type: '" .. Type_b .. "' in function 'getType' must be number or nil")
   
   return Type_a,Type_b, ind_a, ind_b
end

function getDirection(x,y)
   if x>y then
      if x>0 then return 'left' else return 'right' end
   else
      if y>0 then return 'up' else return 'down' end
   end
end

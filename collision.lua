require 'HardonCollider'
require 'goron'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	local Type_a, Type_b, ind_a, ind_b = getType(shape_a,shape_b)
   
   if (Type_a == 'Object' and Type_b == 'goron') or (Type_a == 'goron' and Type_b == 'Object') then
      if Type_a == 'Object' then mtv_x,mtv_y, ind_a, ind_b = -mtv_x, -mtv_y, ind_b, ind_a end
      local w = getDirection(mtv_x,mtv_y)
      gorons[ind_a]:move(mtv_x*2,mtv_y*2) --why times two?
      gorons[ind_a]:turn(w)
      output = 'goron + Object'
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
      output = 'gorons'
   else
      error('unable to determine type')
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
   for i=1,4 do
      if shape_a == Object[i] then Type_a = 'Object' end
      if shape_b == Object[i] then Type_b = 'Object' end
   end
   for i=1,5 do
      if shape_a == goron_bb[i] then Type_a = 'goron' end
      if shape_b == goron_bb[i] then Type_b = 'goron' end
   end
   
   if Type_a == 'Object' then ind_a = whichObject(shape_a)
   elseif Type_a == 'goron' then ind_a = whichGoron(shape_a) end
   if Type_b == 'Object' then ind_b = whichObject(shape_b)
   elseif Type_b == 'goron' then ind_b = whichGoron(shape_b) end
   
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

require 'hardoncollider'
require 'goron'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	local Type_a, Type_b, ind_a, ind_b = getType(shape_a,shape_b)
   
   if (Type_a == 'wall' and Type_b == 'wall') then
      output = 'walls'
   elseif (Type_a == 'wall' and Type_b == 'goron') or (Type_a == 'goron' and Type_b == 'wall') then
      if Type_b == 'wall' then shape_a, shape_b, ind_a, ind_b = shape_b, shape_a, ind_b, ind_a end
      local w = dirWall(ind_a)
      gorons[ind_b]:bounce(w)
      output = 'goron + wall'
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
   local Type_a, Type_b, ind_a, ind_b = getType(shape_a, shape_b)
   if (Type_a == 'wall' and Type_b == 'goron') or (Type_a == 'goron' and Type_b == 'wall') then
      if Type_b == 'wall' then shape_a, shape_b, ind_a, ind_b = shape_b, shape_a, ind_b, ind_a end
      gorons[ind_b]:turn()
   end
end

-- this function determines the location of the wall
-- and thus the direction in which can't be moved
function whichWall(border_shape)
   for i = 1,4 do
      if border_shape == border[i] then
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

function dirWall(mi)
   if mi == 1 then return('up')
   elseif mi == 2 then return('down')
   elseif mi == 3 then return('left')
   elseif mi == 4 then return('right')
   end
end

-- determine type and index number
function getType(shape_a,shape_b)
   local Type_a, Type_b
   local ind_a, ind_b
   for i=1,4 do
      if shape_a == border[i] then Type_a = 'wall' end
      if shape_b == border[i] then Type_b = 'wall' end
   end
   for i=1,5 do
      if shape_a == goron_bb[i] then Type_a = 'goron' end
      if shape_b == goron_bb[i] then Type_b = 'goron' end
   end
   
   if Type_a == 'wall' then ind_a = whichWall(shape_a)
   elseif Type_a == 'goron' then ind_a = whichGoron(shape_a) end
   if Type_b == 'wall' then ind_b = whichWall(shape_b)
   elseif Type_b == 'goron' then ind_b = whichGoron(shape_b) end
   
   assert(type(ind_a) == "number", "ind_a of type: '" .. Type_a .. "' in function 'getType' must be number or nil")
   assert(type(ind_b) == "number", "ind_b of type: '" .. Type_b .. "' in function 'getType' must be number or nil")
   
   return Type_a,Type_b, ind_a, ind_b
end